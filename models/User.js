const db = require('../config/db');

class User {
  static async createUser(userData) {
    const { name, email, password, usertypeID } = userData;
    const [result] = await db.execute(
      'INSERT INTO user (name, email, password, usertypeID) VALUES (?, ?, ?, ?)',
      [name, email, password, usertypeID]
    );
    return result.insertId;
  }

  static async findUserByEmail(email) {
    const [rows] = await db.execute('SELECT * FROM user WHERE email = ?', [email]);
    return rows[0];
  }

  static async findUserById(id) {
    const [rows] = await db.execute('SELECT * FROM user WHERE userID = ?', [id]);
    return rows[0];
  }
}

module.exports = User;