'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Heros', [
      {
        heroName: 'Hritik',
        film: 'Kaho Na Pyaar Hai',
       createdAt: new Date(),
       updatedAt: new Date()       
     },
     {
      heroName: 'Aamir',
      film: 'Lagaan',
     createdAt: new Date(),
     updatedAt: new Date()       
   },
   {
    heroName: 'Shahrukh',
    film: 'Bazigar',
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
