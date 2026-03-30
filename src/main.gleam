import agenda
import gleam/io

pub fn main() {
  let consultas = [
    agenda.Agenda(1, "Ana", "Braço fraturado", "01/01/2026", agenda.Pendente),
    agenda.Agenda(2, "Carlos", "Braço trincado", "02/01/2026", agenda.Concluida),
    agenda.Agenda(3, "Pedro", "Retorno clínico", "03/01/2026", agenda.EmAndamento),
  ]

  io.println("Agenda de Consultas em Gleam")
  io.println(agenda.percentual_concluidas(consultas))
}
