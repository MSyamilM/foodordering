/*
  Warnings:

  - You are about to drop the column `profile_picture` on the `user` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `user` DROP COLUMN `profile_picture`,
    ADD COLUMN `picture` VARCHAR(191) NOT NULL DEFAULT '';
