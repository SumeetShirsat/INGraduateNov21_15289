'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Users', [
      {
       firstName: 'Ankit',
       lastName: 'Arrora',
       createdAt: new Date(),
       updatedAt: new Date()       
     },
     {
      firstName: 'Amit',
      lastName: 'Jha',
      createdAt: new Date(),
      updatedAt: new Date()       
    },

    {

      firstName: 'Ankita',

      lastName: 'Shinde',

      createdAt: new Date(),

      updatedAt: new Date()       

    }

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
