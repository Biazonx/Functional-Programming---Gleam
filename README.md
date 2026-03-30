# Agenda de Consultas em Gleam

Projeto acadêmico de **programação funcional** escrito em `Gleam` para gerenciar uma agenda de consultas de forma simples e imutável.

> A small Gleam project for managing appointments using functional programming.

## Funcionalidades

- criação de consultas com validação
- busca de consulta por `id`
- atualização de status
- filtragem por situação
- remoção de consultas concluídas
- cálculo de estatísticas da agenda

## Estrutura do projeto

```text
.
├── .github/workflows/ci.yml
├── src/
│   ├── agenda.gleam
│   └── main.gleam
├── test/
│   └── agenda_test.gleam
├── gleam.toml
├── .gitignore
└── README.md
```

## Executar localmente

```bash
gleam run
```

## Rodar testes

```bash
gleam test
```

## Exemplo de uso

```gleam
import agenda
import gleam/io

pub fn main() {
  let assert Ok(consulta) =
    agenda.criar_consulta(
      1,
      "Ana",
      "Retorno clínico",
      "01/04/2026",
      agenda.Pendente,
    )

  io.debug(consulta)
}
```


