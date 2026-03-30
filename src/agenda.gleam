import gleam/float
import gleam/int
import gleam/list
import gleam/string

/// Status possíveis para uma consulta.
pub type Status {
  Pendente
  EmAndamento
  Concluida
}

/// Registro principal da agenda de consultas.
pub type Agenda {
  Agenda(
    id: Int,
    nome: String,
    descricao: String,
    data: String,
    status: Status,
  )
}

/// Cria uma consulta apenas se todos os campos forem válidos.
pub fn criar_consulta(
  id: Int,
  nome: String,
  descricao: String,
  data: String,
  status: Status,
) -> Result(Agenda, String) {
  case validar_consulta(id, nome, descricao, data, status) {
    True -> Ok(Agenda(id, nome, descricao, data, status))
    False -> Error("Não foi possível criar a consulta")
  }
}

fn validar_consulta(
  id: Int,
  nome: String,
  descricao: String,
  data: String,
  status: Status,
) -> Bool {
  case
    validar_id(id),
    validar_texto(nome),
    validar_texto(descricao),
    validar_data(data),
    validar_status(status)
  {
    Ok(_), Ok(_), Ok(_), Ok(_), Ok(_) -> True
    _, _, _, _, _ -> False
  }
}

fn validar_id(id: Int) -> Result(Int, Nil) {
  case id > 0 {
    True -> Ok(id)
    False -> Error(Nil)
  }
}

fn validar_texto(texto: String) -> Result(String, Nil) {
  case string.length(texto) > 0 {
    True -> Ok(texto)
    False -> Error(Nil)
  }
}

fn validar_data(data: String) -> Result(String, Nil) {
  case
    string.length(data) == 10
    && string.slice(data, 2, 1) == "/"
    && string.slice(data, 5, 1) == "/"
  {
    True -> Ok(data)
    False -> Error(Nil)
  }
}

fn validar_status(status: Status) -> Result(Status, Nil) {
  case status {
    Pendente -> Ok(Pendente)
    EmAndamento -> Ok(EmAndamento)
    Concluida -> Ok(Concluida)
  }
}

/// Adiciona uma nova consulta ao final da lista.
pub fn adicionar_consulta(
  consultas: List(Agenda),
  consulta: Agenda,
) -> List(Agenda) {
  case consultas {
    [] -> [consulta]
    [primeiro, ..resto] -> [primeiro, ..adicionar_consulta(resto, consulta)]
  }
}

/// Atualiza o status de uma consulta encontrada pelo id.
pub fn atualizar_status(
  consultas: List(Agenda),
  id: Int,
  novo_status: Status,
) -> Result(Agenda, String) {
  case busca_por_id(consultas, id) {
    Ok(consulta_procurada) ->
      Ok(Agenda(..consulta_procurada, status: novo_status))
    Error(mensagem_de_erro) -> Error(mensagem_de_erro)
  }
}

/// Busca uma consulta por identificador.
pub fn busca_por_id(agenda: List(Agenda), id: Int) -> Result(Agenda, String) {
  case agenda {
    [] -> Error("Id não encontrado")
    [primeiro, ..] if primeiro.id == id -> Ok(primeiro)
    [_, ..resto] -> busca_por_id(resto, id)
  }
}

/// Filtra as consultas de acordo com o status informado.
pub fn filtra_por_status(agenda: List(Agenda), status: Status) -> List(Agenda) {
  case agenda {
    [] -> []
    [primeira, ..resto] if primeira.status != status ->
      filtra_por_status(resto, status)
    [primeira, ..resto] -> [primeira, ..filtra_por_status(resto, status)]
  }
}

/// Remove todas as consultas já concluídas.
pub fn remove_concluidas(agenda: List(Agenda)) -> List(Agenda) {
  case agenda {
    [] -> []
    [primeira, ..resto] if primeira.status == Concluida ->
      remove_concluidas(resto)
    [primeira, ..resto] -> [primeira, ..remove_concluidas(resto)]
  }
}

/// Conta quantas consultas existem para um dado status.
pub fn contar_por_status(agenda: List(Agenda), status: Status) -> Int {
  list.length(filtra_por_status(agenda, status))
}

/// Retorna o percentual de consultas concluídas como texto legível.
pub fn percentual_concluidas(agenda: List(Agenda)) -> String {
  case list.length(agenda) == 0 {
    True -> "O percentual de consultas concluídas é de 0.0%"
    False -> {
      let quantidade_total = int.to_float(list.length(agenda))
      let quantidade_concluidas =
        int.to_float(contar_por_status(agenda, Concluida))
      let percentual =
        float.to_string({ quantidade_concluidas /. quantidade_total } *. 100.0)

      "O percentual de consultas concluídas é de "
      <> string.slice(percentual, 0, 4)
      <> "%"
    }
  }
}
