import agenda
import gleeunit

pub fn main() {
  gleeunit.main()
}

pub fn criar_consulta_valida_test() {
  let assert Ok(consulta) =
    agenda.criar_consulta(
      1,
      "Pedro",
      "Retorno",
      "12/02/2026",
      agenda.Pendente,
    )

  assert consulta.id == 1
}

pub fn criar_consulta_invalida_test() {
  let assert Error("Não foi possível criar a consulta") =
    agenda.criar_consulta(
      0,
      "",
      "Consulta inválida",
      "12-02-2026",
      agenda.Pendente,
    )
}

pub fn contar_por_status_test() {
  let consultas = [
    agenda.Agenda(1, "Ana", "Retorno", "01/01/2026", agenda.Concluida),
    agenda.Agenda(2, "Bruno", "Exame", "02/01/2026", agenda.Pendente),
    agenda.Agenda(3, "Carla", "Revisão", "03/01/2026", agenda.Concluida),
  ]

  assert agenda.contar_por_status(consultas, agenda.Concluida) == 2
}

pub fn percentual_vazio_test() {
  assert agenda.percentual_concluidas([]) ==
    "O percentual de consultas concluídas é de 0.0%"
}
