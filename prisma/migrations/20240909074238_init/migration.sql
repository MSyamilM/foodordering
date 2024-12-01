/*
  Warnings:

  - Added the required column `updatedAt` to the `OrderList` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `order` DROP FOREIGN KEY `Order_idUser_fkey`;

-- DropForeignKey
ALTER TABLE `orderlist` DROP FOREIGN KEY `OrderList_idMenu_fkey`;

-- DropForeignKey
ALTER TABLE `orderlist` DROP FOREIGN KEY `OrderList_idOrder_fkey`;

-- AlterTable
ALTER TABLE `order` MODIFY `idUser` INTEGER NULL;

-- AlterTable
ALTER TABLE `orderlist` ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL,
    MODIFY `idOrder` INTEGER NULL,
    MODIFY `idMenu` INTEGER NULL;

-- AddForeignKey
ALTER TABLE `Order` ADD CONSTRAINT `Order_idUser_fkey` FOREIGN KEY (`idUser`) REFERENCES `User`(`idUser`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderList` ADD CONSTRAINT `OrderList_idOrder_fkey` FOREIGN KEY (`idOrder`) REFERENCES `Order`(`idOrder`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderList` ADD CONSTRAINT `OrderList_idMenu_fkey` FOREIGN KEY (`idMenu`) REFERENCES `Menu`(`idMenu`) ON DELETE SET NULL ON UPDATE CASCADE;
