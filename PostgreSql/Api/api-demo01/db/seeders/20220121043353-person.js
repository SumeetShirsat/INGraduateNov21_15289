'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
      await queryInterface.bulkInsert('People', [
        {
        firstName: 'John',
        lastName:'Doe',
        createdAt: new Date(),
        updatedAt: new Date()
       },
       {
        firstName: 'Gordan',
        lastName:'Bombay',
        createdAt: new Date(),
        updatedAt: new Date()
       },
    ], {});
     },

  down: async (queryInterface, Sequelize) => {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};
