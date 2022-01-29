'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Users', [
      {
       name: 'Sumeet',
       mobileNo: 8169743524,
       emailId:'sumeet2132@gmail.com',
       password:'Sumeet@10',
       createdAt: new Date(),
       updatedAt: new Date()
     },
     {
      name: 'Ajay',
      mobileNo: 8169743523,
      emailId:'ajay2132@gmail.com',
      password:'AjayTri@10',
      createdAt: new Date(),
      updatedAt: new Date()
    },



    ], {});
  },


  async down (queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};
