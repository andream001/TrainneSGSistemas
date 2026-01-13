# Script para salvar automaticamente no GitHub
# Execute este script sempre que quiser enviar suas alteracoes

Set-Location "c:\Program Files (x86)\SG Sistemas\Projeto SGTrainee\workdir"

Write-Host "Verificando alteracoes..." -ForegroundColor Cyan

# Adicionar todos os arquivos modificados
git add .

# Verificar se ha algo para commitar
$status = git status --porcelain
if ($status) {
    # Criar commit com data e hora
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    git commit -m "Auto-save: $timestamp"
    
    Write-Host "Enviando para o GitHub..." -ForegroundColor Green
    git push
    
    Write-Host "Salvo com sucesso no GitHub!" -ForegroundColor Green
} else {
    Write-Host "Nenhuma alteracao para salvar." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Pressione qualquer tecla para fechar..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
