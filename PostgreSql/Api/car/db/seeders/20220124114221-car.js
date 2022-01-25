'use strict';

module.exports = {
  
    async up (queryInterface, Sequelize) {
      await queryInterface.bulkInsert('Cars', [
        {
          carName: 'Nano',
          brandName: 'Tata',
         createdAt: new Date(),
         updatedAt: new Date()       
       },
       {
        carName: 'Creta',
        brandName: 'Hyundai',
       createdAt: new Date(),
       updatedAt: new Date()       
     },
     {
      carName: 'XUV700',
      brandName: 'Mahindra',
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
