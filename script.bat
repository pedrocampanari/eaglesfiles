@echo off
setlocal enabledelayedexpansion

:: Verifica se o Git está no PATH
where git >nul 2>&1
if errorlevel 1 (
    echo Git nao encontrado em seu sistema.
    echo Abrindo a pagina oficial para download...
    start https://git-scm.com/download/win
    echo.
    echo Por favor, instale o Git manualmente e execute este script novamente.
    pause
    exit /b
)

:: Verifica se está dentro de um repositório Git
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ERRO: Este diretório não é um repositório Git.
    pause
    exit /b
)

:: Executa git pull
echo.
echo Atualizando repositório local com: git pull
echo ===============================
git pull
if errorlevel 1 (
    echo ERRO ao executar git pull. Verifique conflitos ou problemas de rede.
    pause
    exit /b
)

:: Adiciona arquivos
echo.
echo Adicionando arquivos com: git add .
echo ===============================
git add .
if errorlevel 1 (
    echo ERRO ao adicionar arquivos.
    pause
    exit /b
)

:: Solicita mensagem do commit
echo.
set /p commitMsg="Digite a mensagem do commit: "
if "%commitMsg%"=="" (
    echo ERRO: Mensagem de commit não pode ser vazia.
    pause
    exit /b
)

:: Executa git commit
echo.
echo Realizando commit...
echo ===============================
git commit -m "%commitMsg%"
if errorlevel 1 (
    echo ERRO ao realizar o commit.
    pause
    exit /b
)

:: Executa git push
echo.
echo Enviando para o repositório remoto com: git push
echo ===============================
git push
if errorlevel 1 (
    echo ERRO ao fazer push para o repositório remoto.
    pause
    exit /b
)

echo.
echo Todas as etapas foram concluídas com sucesso!
pause
endlocal
