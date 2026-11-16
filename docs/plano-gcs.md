# Plano de Gerência de Configuração de Software (GCS)

**Projeto:** app_jogos (`game_backlog`) – aplicativo Flutter para organizar o backlog de jogos
**Repositório:** https://github.com/fernandohoffmann/app_jogos
**Responsável (autor/mantenedor):** Fernando Hoffmann da Silva (@fernandohoffmann)
**Par de revisão:** @MateusMaciel999
**Disciplina:** Engenharia de Software 4B – N2-P2
**Versão do plano:** 1.0 – 16/11/2026

> Este documento é, ele próprio, um **item de configuração (IC)** do projeto: está versionado em `docs/plano-gcs.md` e só pode ser alterado por Pull Request revisado.

## 1. Objetivo e escopo
Definir como os itens do projeto são identificados, controlados, auditados e liberados, garantindo rastreabilidade e integridade da `main`. Aplica-se a todo o conteúdo do repositório.

## 2. Itens de configuração (IC)
| ID | Item | Caminho | Tipo |
|----|------|---------|------|
| IC-01 | Código-fonte do app | `lib/` | Código |
| IC-02 | Dependências e versão | `pubspec.yaml` | Configuração |
| IC-03 | Regras de análise estática | `analysis_options.yaml` | Configuração |
| IC-04 | Projetos de plataforma | `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/` | Configuração |
| IC-05 | Pipeline de CI/CD | `.github/workflows/` | Automação |
| IC-06 | Plano de GCS | `docs/plano-gcs.md` | Documento |
| IC-07 | Regras de revisão | `.github/CODEOWNERS`, `.github/pull_request_template.md` | Processo |
| IC-08 | README | `README.md` | Documento |

Arquivos gerados (`build/`, `.dart_tool/`) **não** são IC e ficam no `.gitignore`.

## 3. Estrutura do repositório
```
app_jogos/
├── lib/                 # código (main.dart, models/, screens/)
├── android/ ios/ web/ linux/ macos/ windows/
├── docs/                # plano-gcs.md e evidências
├── .github/
│   ├── workflows/ci.yml
│   ├── CODEOWNERS
│   └── pull_request_template.md
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

## 4. Estratégia de branches
- `main`: sempre estável; **protegida**, recebe apenas merge de PR aprovado.
- `feature/<descricao>`, `fix/<descricao>`, `docs/<descricao>`: ramos curtos, criados a partir da `main` e removidos após o merge.

## 5. Convenção de commits e versionamento
- Commits no formato `tipo: descrição` (`feat`, `fix`, `docs`, `chore`, `refactor`, `test`).
- Versionamento semântico `MAJOR.MINOR.PATCH` no campo `version` do `pubspec.yaml`.
- Releases marcados com tags `vX.Y.Z` na `main`.

## 6. Controle de mudanças (fluxo)
1. Registrar a necessidade de mudança (issue).
2. Criar branch a partir da `main`.
3. Fazer commits pequenos e descritivos.
4. Abrir Pull Request usando o template.
5. O CI executa `flutter analyze` e `flutter test` e deve passar.
6. **Revisão por pelo menos 1 aprovador** (o par de revisão, com acesso de escrita). O autor não aprova o próprio PR.
7. Merge na `main` e remoção do branch.

## 7. Proteção da `main` (regras configuradas no GitHub)
- Push direto bloqueado: alteração somente via Pull Request.
- Mínimo de 1 aprovação; aprovações obsoletas descartadas a cada novo commit.

- Conversas resolvidas antes do merge.
- Force-push e exclusão da branch proibidos; regra vale também para administradores.

## 8. Papéis
| Papel | Pessoa | Permissão |
|-------|--------|-----------|
| Autor / mantenedor | @fernandohoffmann | Admin |
| Par de revisão | @MateusMaciel999 | Write |

## 9. Ambientes e liberação
| Environment | Finalidade | Proteção |
|-------------|-----------|----------|
| `staging` | Homologação / validação antes da liberação | Sem aprovação obrigatória; restrito à `main` |
| `production` | Versão liberada ao usuário | **Revisor obrigatório: @fernandohoffmann**; restrito à `main` |

O fluxo (`.github/workflows/ci.yml`) executa: CI → deploy `staging` → (aprovação manual) → deploy `production`.

## 10. Auditoria e rastreabilidade
- Histórico de commits, PRs e revisões no GitHub.
- Abas *Actions* e *Deployments* registram cada execução e aprovação de ambiente.
- Evidência da proteção da `main` (recusa de push direto) em `docs/evidencias/`.

## 11. Backup e recuperação
O repositório remoto no GitHub é a cópia mestre; cada integrante mantém clone local. Recuperação por `git clone` e checkout da tag desejada.

## 12. Revisão do plano
Revisado a cada entrega da disciplina ou quando o processo mudar, sempre via PR.
