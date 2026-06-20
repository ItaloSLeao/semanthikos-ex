# Documentação Técnica: Event Manager

Este documento fornece uma visão profunda e técnica sobre a arquitetura, as tecnologias e os processos operacionais do sistema **Event Manager**.

---

## 1. Arquitetura do Projeto

O projeto utiliza o **Phoenix Framework** (baseado em Elixir), seguindo uma arquitetura de **Contextos Consolidados**.

### 1.1 Camada de Negócio (`lib/event_manager/`)
Abandonamos a fragmentação excessiva em favor de "Gerentes de Domínio":
- **`Core` (`core.ex`):** Centraliza o ciclo de vida principal. Gerencia usuários (autenticação, perfis) e eventos (criação, listagem, inscrições).
- **`Services` (`services.ex`):** Agrupa funcionalidades de apoio que consomem dados do Core, como geração de certificados, relatórios analíticos e lógica de chat.
- **`Schemas` (`schemas/`):** Contém as definições de dados (Ecto Schemas). Eles são "burros", focados em estrutura e validações de dados (changesets).
- **`UserNotifier` (`user_notifier.ex`):** Responsável pela ponte de comunicação por e-mail.

### 1.2 Camada Web (`lib/event_manager_web/`)
- **`Controllers`:** Lidam com requisições HTTP REST/HTML tradicionais.
- **`LiveView` (`live/`):** Onde a mágica acontece. Permite interfaces ricas e em tempo real (como o Chat e Dashboards) sem escrever JavaScript complexo.
- **`Channels` (`channels/`):** Camada de transporte para WebSockets puros, usada para comunicações de baixa latência.
- **`Router` (`router.ex`):** O "GPS" do sistema, contendo pipelines de segurança (RBAC) que filtram o acesso por papel (Admin, Palestrante, Estudante).

---

## 2. Tecnologias de Ponta

| Tecnologia | Função | Por que usamos? |
| :--- | :--- | :--- |
| **Elixir/Erlang VM** | Runtime | Concorrência imbatível. Cada usuário é um processo isolado e leve. |
| **Phoenix LiveView** | Frontend Dinâmico | Mantém o estado no servidor. Atualiza a tela via WebSockets. Zero boilerplate de SPA. |
| **PostgreSQL** | Banco de Dados | Robustez e suporte a buscas complexas (Full-Text Search). |
| **Ecto** | ORM/Query Builder | Permite transações atômicas seguras (Ecto.Multi) e prevenção de SQL Injection. |
| **Tailwind CSS** | Estilização | Design moderno e responsivo com baixo peso de arquivo. |

---

## 3. Padrões de Implementação Interna

### 3.1 Reserva Atômica de Vagas
Para evitar que dois usuários se inscrevam na última vaga ao mesmo tempo, usamos `Ecto.Multi` no `EventManager.Repo.reserve_seat/2`. Ele garante que a verificação de vagas e a inserção da inscrição ocorram como uma única operação indivisível no banco de dados.

### 3.2 Role-Based Access Control (RBAC)
A segurança não é verificada apenas na tela, mas no nível da rota.
- **Admin:** Controle total do ecossistema.
- **Speaker:** Gerencia apenas seus eventos e presenças.
- **Student:** Participa e consome certificados.

---

## 4. Ecossistema do Projeto (Pastas Externas)

- **`config/`:** O "painel de controle". Define URLs, portas, credenciais e comportamentos por ambiente (dev, test, prod).
- **`priv/`:** O "bastidor". Contém as migrações (evolução do banco), arquivos estáticos (logos/imagens) e scripts de carga inicial (`seeds.exs`).
- **`assets/`:** O "camarim". Onde o CSS e JS brutos são processados.
- **`deps/`:** A "caixa de ferramentas". Bibliotecas externas instaladas.
- **`_build/`:** O "produto final". Onde o código compilado reside.

---

## 5. Como Operar o Projeto

### 5.1 Rodando pela primeira vez
```bash
# Instala bibliotecas, cria banco, migra tabelas e gera dados de teste
mix setup
```

### 5.2 Execução Diária
```bash
# Inicia o servidor e o terminal interativo (muito útil para depurar)
iex -S mix phx.server
```
Acesse: `http://localhost:4000`

### 5.3 Verificação de Qualidade
```bash
# Roda todos os testes automatizados
mix test

# Formata o código conforme os padrões da comunidade
mix format
```

### 5.4 Comandos de Emergência
- `mix ecto.reset`: Apaga tudo e recria o banco (use com cuidado!).
- `mix deps.get`: Baixa bibliotecas novas adicionadas ao projeto.
- `mix compile --force`: Força a recompilação se algo parecer estranho.

---

## 6. Filosofia de Desenvolvimento
Este projeto preza pela **clareza sobre a complexidade**. Antes de criar uma nova pasta ou um novo contexto, pergunte-se: "Isso pode ser uma nova função dentro do `Core` ou `Services`?". Mantenha a arquitetura plana e os fluxos de dados explícitos.
