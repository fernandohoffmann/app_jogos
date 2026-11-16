# app_jogos (game_backlog)

Aplicativo Flutter para organizar o backlog de jogos (Quero jogar / Jogando / Zerado), com persistência local via `shared_preferences`.

## Estrutura
- `lib/` – código-fonte (`models/`, `screens/`)
- `docs/plano-gcs.md` – **Plano de Gerência de Configuração de Software**
- `.github/` – CI/CD, CODEOWNERS e template de PR

## Como rodar
```bash
flutter pub get
flutter run
```

## Fluxo de contribuição
A `main` é protegida: crie um branch (`feature/...`), abra um Pull Request e aguarde a revisão do par. Detalhes no [plano de GCS](docs/plano-gcs.md).

## Ambientes
`staging` e `production` (este com revisor obrigatório) – veja a seção 9 do plano de GCS.
