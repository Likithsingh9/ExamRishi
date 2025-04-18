import crypto from 'crypto';
import { Purchase } from '../models/Purchase.js';

export const razorpayWebhook = async (req, res) => {
    const secret = process.env.RAZORPAY_KEY_SECRET;

    const shasum = crypto.createHmac('sha256', secret);
    shasum.update(JSON.stringify(req.body));
    const digest = shasum.digest('hex');

    if (digest === req.headers['x-razorpay-signature']) {
        const { payload } = req.body;

        // Extract payment ID and order ID from the payload
        const paymentId = payload.payment.entity.id;
        const orderId = payload.order.entity.id;

        // Find the Purchase record by Razorpay order ID (stored in receipt)
        const purchase = await Purchase.findOne({ _id: req.body.payload.payment.entity.order_id });

        if (purchase) {
            purchase.paymentId = paymentId;
            purchase.status = 'completed'; // Or 'processing', depending on your flow
            await purchase.save();
            console.log(`Purchase ${purchase._id} updated with payment ID ${paymentId}`);
        } else {
            console.error(\`Purchase with receipt ${orderId} not found.\`);
        }

        res.status(200).json({ status: 'ok' });
    } else {
        res.status(400).json({ status: 'error', message: 'Invalid signature' });
    }
};