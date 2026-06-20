# Contexto do Projeto: Event Manager

Este documento serve como um registro vivo do panorama do projeto, capturando a visão técnica, decisões arquiteturais e a evolução do sistema sob a perspectiva de desenvolvimento sênior.

---

## 1. Panorama Atual (Maio/2026)

### 1.1 Proposta e Objetivo
O **Event Manager** é uma plataforma full-stack para gestão de eventos acadêmicos. O foco é a eficiência e simplicidade, mantendo a robustez necessária para operações críticas, como a reserva de assentos, sem incorrer em complexidade excessiva.

### 1.2 Arquitetura: "Gerentes de Departamento"
O projeto utiliza uma variação da arquitetura de contextos do Phoenix (**Consolidated Contexts**):
- **Camada de Dados (`lib/event_manager/schemas/`):** Centraliza definições de tabela.
- **Gerente Principal (`Core.ex`):** Autenticação, Usuários e CRUD de Eventos/Inscrições.
- **Gerente de Apoio (`Services.ex`):** Isola Chat (tempo real), Certificados e Relatórios.
- **Reserva Atômica:** Implementação em `Repo.reserve_seat/2` para garantir consistência em concorrência.

### 1.3 Stack Tecnológica
- **Elixir & Phoenix 1.7:** Base moderna e performática.
- **LiveView:** Interfaces ricas e reativas mantendo o estado no servidor.
- **PostgreSQL:** Consistência e integridade de dados.
- **RBAC (Role-Based Access Control):** Controle de permissões centralizado no `router.ex`.

### 1.4 Pontos Fortes e Diferenciais
1. **Baixo Boilerplate:** Arquitetura plana facilita a manutenção.
2. **Segurança:** Uso de `bcrypt_elixir` e RBAC estruturado.
3. **Escalabilidade:** Preparado para tarefas intensivas (PDFs, CSVs) e tempo real (WebSockets).

---

## 2. Histórico de Contextos e Evolução

*(Novos contextos e marcos importantes devem ser adicionados aqui)*

### [2026-05-19] Segurança Atômica e Comunicação em Tempo Real
- **Cancelamento Seguro de Eventos:** Implementação de `Ecto.Multi` no `Core.cancel_event/1`. Agora, o cancelamento do evento e a notificação global para os inscritos ocorrem como uma unidade de trabalho indivisível, garantindo que nenhum usuário fique sem aviso em caso de falha.
- **Arquitetura de WebSockets (Channels):** Consolidação dos `Phoenix Channels` para o Chat e Notificações. Diferente de uma implementação simples, agora o sistema suporta comunicação bidirecional verdadeira, permitindo que clientes (web/mobile) e o servidor troquem mensagens de baixa latência fora do ciclo de vida tradicional do LiveView quando necessário.
- **Sincronização LiveView <> Channels:** Refatoração do `EventChatLive` para interceptar e formatar mensagens vindas de canais WebSocket, garantindo uma interface reativa e consistente.

---

## 3. Diretrizes para Futuros Desenvolvedores
- **Clareza > Complexidade:** Antes de criar novos contextos, verifique se a lógica cabe em `Core` ou `Services`.
- **Atomicidade:** Sempre use transações (`Ecto.Multi`) para operações que envolvem múltiplos passos ou recursos limitados.
- **Testes:** Adicione testes para cada nova funcionalidade nos contextos consolidados.
