/*
  Warnings:

  - You are about to drop the `Atividade` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Curso` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ResultadoAtividade` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Unidade` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."Atividade" DROP CONSTRAINT "Atividade_unidadeId_fkey";

-- DropForeignKey
ALTER TABLE "public"."ResultadoAtividade" DROP CONSTRAINT "ResultadoAtividade_atividadeId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Unidade" DROP CONSTRAINT "Unidade_cursoId_fkey";

-- DropTable
DROP TABLE "public"."Atividade";

-- DropTable
DROP TABLE "public"."Curso";

-- DropTable
DROP TABLE "public"."ResultadoAtividade";

-- DropTable
DROP TABLE "public"."Unidade";

-- CreateTable
CREATE TABLE "Curso" (
    "id" SERIAL NOT NULL,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,

    CONSTRAINT "Curso_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Unidade" (
    "id" SERIAL NOT NULL,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "links" TEXT[],
    "anexos" TEXT[],
    "cursoId" INTEGER NOT NULL,

    CONSTRAINT "Unidade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Atividade" (
    "id" SERIAL NOT NULL,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "unidadeId" INTEGER NOT NULL,

    CONSTRAINT "Atividade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ResultadoAtividade" (
    "id" SERIAL NOT NULL,
    "atividadeId" INTEGER NOT NULL,
    "aluno_id" TEXT NOT NULL,
    "resposta" TEXT NOT NULL,
    "data_envio" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ResultadoAtividade_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Unidade" ADD CONSTRAINT "Unidade_cursoId_fkey" FOREIGN KEY ("cursoId") REFERENCES "Curso"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Atividade" ADD CONSTRAINT "Atividade_unidadeId_fkey" FOREIGN KEY ("unidadeId") REFERENCES "Unidade"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ResultadoAtividade" ADD CONSTRAINT "ResultadoAtividade_atividadeId_fkey" FOREIGN KEY ("atividadeId") REFERENCES "Atividade"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
