-- CreateTable
CREATE TABLE `Menu` (
    `idMenu` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `price` INTEGER NOT NULL,
    `category` ENUM('FOOD', 'DRINK', 'SNACK') NOT NULL DEFAULT 'FOOD',
    `picture` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,

    UNIQUE INDEX `Menu_uuid_key`(`uuid`),
    PRIMARY KEY (`idMenu`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User` (
    `idUser` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `profile_picture` VARCHAR(191) NULL,
    `role` ENUM('MANAGER', 'CASHIER') NOT NULL DEFAULT 'CASHIER',

    UNIQUE INDEX `User_uuid_key`(`uuid`),
    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`idUser`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Order` (
    `idOrder` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL,
    `customer` VARCHAR(191) NOT NULL,
    `table_number` VARCHAR(191) NOT NULL,
    `total_price` INTEGER NOT NULL,
    `payment_method` ENUM('CASH', 'QRIS') NOT NULL DEFAULT 'CASH',
    `idUser` INTEGER NOT NULL,
    `status` ENUM('NEW', 'PAID', 'DONE') NOT NULL DEFAULT 'NEW',

    UNIQUE INDEX `Order_uuid_key`(`uuid`),
    PRIMARY KEY (`idOrder`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `OrderList` (
    `idOrderList` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL,
    `idOrder` INTEGER NOT NULL,
    `idMenu` INTEGER NOT NULL,
    `quantity` INTEGER NOT NULL,
    `note` VARCHAR(191) NOT NULL DEFAULT '',

    UNIQUE INDEX `OrderList_uuid_key`(`uuid`),
    PRIMARY KEY (`idOrderList`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Order` ADD CONSTRAINT `Order_idUser_fkey` FOREIGN KEY (`idUser`) REFERENCES `User`(`idUser`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderList` ADD CONSTRAINT `OrderList_idOrder_fkey` FOREIGN KEY (`idOrder`) REFERENCES `Order`(`idOrder`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderList` ADD CONSTRAINT `OrderList_idMenu_fkey` FOREIGN KEY (`idMenu`) REFERENCES `Menu`(`idMenu`) ON DELETE RESTRICT ON UPDATE CASCADE;
