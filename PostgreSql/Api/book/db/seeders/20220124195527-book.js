'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Books', [
      {
        bookName: 'Angular',
        authorName: 'Ajay',
        publicationDate:new Date(),
        createdAt: new Date(),
        updatedAt: new Date()       
     },
     {
      bookName: 'Sql',
      authorName: 'Ganesh',
      publicationDate:new Date(),
      createdAt: new Date(),
      updatedAt: new Date()       
   },
   {
    bookName: 'Koushik',
    authorName: 'Html',
    publicationDate:new Date(),
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
