# Seeds for Event Manager System

alias EventManager.Core
alias EventManager.Repo

# Create admin user
{:ok, admin} = Core.register_admin(%{
  email: "admin@eventmanager.com",
  name: "Administrador do Sistema",
  password: "Admin@123",
  course: "Ciência da Computação",
  department: "Departamento de Computação"
})

# Create sample speakers
{:ok, speaker1} = Core.register_speaker(%{
  email: "professor@universidade.edu.br",
  name: "Dr. João Silva",
  password: "Speaker@123",
  department: "Departamento de Computação",
  bio: "Professor titular com 20 anos de experiência em Inteligência Artificial"
})

{:ok, speaker2} = Core.register_speaker(%{
  email: "pesquisador@instituto.org.br",
  name: "Dra. Maria Santos",
  password: "Speaker@123",
  department: "Departamento de Matemática",
  bio: "Pesquisadora em Machine Learning e Data Science"
})

# Create sample students
{:ok, student1} = Core.register_user(%{
  email: "aluno1@universidade.edu.br",
  name: "Pedro Oliveira",
  password: "Student@123",
  role: :student,
  course: "Ciência da Computação",
  department: "Departamento de Computação"
})

{:ok, student2} = Core.register_user(%{
  email: "aluno2@universidade.edu.br",
  name: "Ana Costa",
  password: "Student@123",
  role: :student,
  course: "Engenharia de Software",
  department: "Departamento de Computação"
})

{:ok, student3} = Core.register_user(%{
  email: "aluno3@universidade.edu.br",
  name: "Lucas Mendes",
  password: "Student@123",
  role: :student,
  course: "Sistemas de Informação",
  department: "Departamento de Computação"
})

# Create sample events
event1_date = DateTime.utc_now() |> DateTime.add(7 * 24 * 60 * 60, :second)
{:ok, event1} = Core.create_event(%{
  title: "Introdução à Inteligência Artificial",
  description: """
  Workshop introdutório sobre os fundamentos de Inteligência Artificial.
  Abordaremos conceitos básicos de machine learning, redes neurais e aplicações práticas.
  O evento inclui demonstrações práticas e discussões sobre o futuro da IA.
  """,
  date: event1_date,
  duration_minutes: 120,
  location: "Auditório Principal - Bloco A",
  max_seats: 100,
  status: :published,
  speaker_id: speaker1.id,
  is_online: false,
  tags: ["Inteligência Artificial", "Machine Learning", "Workshop"]
})

event2_date = DateTime.utc_now() |> DateTime.add(14 * 24 * 60 * 60, :second)
{:ok, event2} = Core.create_event(%{
  title: "Data Science na Prática",
  description: """
  Palestra sobre aplicações práticas de Data Science em ambientes corporativos.
  Serão apresentados cases reais de análise de dados e tomada de decisão baseada em dados.
  """,
  date: event2_date,
  duration_minutes: 90,
  location: "Online via Zoom",
  max_seats: 200,
  status: :published,
  speaker_id: speaker2.id,
  is_online: true,
  online_url: "https://zoom.us/meeting/example",
  tags: ["Data Science", "Análise de Dados", "Online"]
})

event3_date = DateTime.utc_now() |> DateTime.add(21 * 24 * 60 * 60, :second)
{:ok, event3} = Core.create_event(%{
  title: "Elixir e Phoenix: Desenvolvimento Web Moderno",
  description: """
  Minicurso prático sobre desenvolvimento web com Elixir e Phoenix Framework.
  Aprenda a criar aplicações web escaláveis e de alta performance.
  """,
  date: event3_date,
  duration_minutes: 180,
  location: "Laboratório de Informática - Sala 101",
  max_seats: 30,
  status: :published,
  speaker_id: speaker1.id,
  is_online: false,
  tags: ["Elixir", "Phoenix", "Web Development", "Minicurso"]
})

# Register students for events
{:ok, _} = Core.register_for_event(event1.id, student1.id)
{:ok, _} = Core.register_for_event(event1.id, student2.id)
{:ok, _} = Core.register_for_event(event1.id, student3.id)

{:ok, _} = Core.register_for_event(event2.id, student1.id)
{:ok, _} = Core.register_for_event(event2.id, student2.id)

{:ok, _} = Core.register_for_event(event3.id, student3.id)

IO.puts("Seed data created successfully!")
IO.puts("Admin: admin@eventmanager.com / Admin@123")
IO.puts("Speaker: professor@universidade.edu.br / Speaker@123")
IO.puts("Student: aluno1@universidade.edu.br / Student@123")