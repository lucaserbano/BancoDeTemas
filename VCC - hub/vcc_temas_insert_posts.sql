-- Importacao de temas VCC para tabela posts
-- Gerado automaticamente a partir de: Projeto - Marketing VCC 2026.xlsx (aba TEMAS)
-- Cliente destino: eb9aa951-b915-4b09-9c34-072b56afe4e0
-- Total de registros: 174

BEGIN;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM clientes WHERE id = 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid) THEN
    RAISE EXCEPTION 'cliente_id % nao encontrado na tabela clientes', 'eb9aa951-b915-4b09-9c34-072b56afe4e0';
  END IF;
END $$;

INSERT INTO posts (
  id, cliente_id, titulo, linha, subtema, formato, funil, serie, mes, status, likes, comentarios, data_publicacao, gancho, orientacoes
) VALUES
  ('c86f4e2c-2846-59d0-bb17-1ed1a82ab6e9'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que muda quando você é avaliado por uma equipe focada em valvopatias?', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 2)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES, CLÍNICOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('cea5150c-2571-5c2d-ba2c-a0bb8ea47014'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'X Estudos que revolucionaram o manejo das valvopatias', 'Inspiracao', '', 'Reels', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 3)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('4bd4714d-6965-53ae-9715-e01ee67e3e91'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O ponto de virada: por que fundamos o Valve Care Center?', 'Inspiracao', '', 'Carrossel', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 4)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('f63256b4-3039-5af5-9bc2-ff43847786ef'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Como a tecnologia tem transformado os desfechos dos pacientes?', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 5)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('f586622d-e8be-5b53-8b48-ea41b9d2adec'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Por que existem casos difíceis? (Uma reflexão sobre prevenção)', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 6)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('2a7132d0-a5ac-5677-a3d5-6bdca90d0b02'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'A diferença entre tratar um diagnóstico e tratar uma pessoa', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 7)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('9f1116b1-3814-5078-9c36-bec6a1bc6f7f'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O valor da nossa equipe multidisciplinar na sua saúde', 'Inspiracao', '', 'Carrossel', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 8)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('970beb60-88d5-59eb-971d-93664eceb98b'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Medicina de precisão sem deixar de lado a humanidade', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 9)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('d7ed76bf-09c4-54a5-9e4c-6d49abac752d'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'De olho no ecocardiograma: você sabe como funciona?', 'Inspiracao', '', 'Reels', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 10)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('fdd82949-9e3c-59de-9141-b71aec515e58'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Procedimento X: por que foi indicado nesse caso?', 'Inspiracao', '', 'Reels', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 11)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('079bd58d-1342-5777-91cf-88b62862c3e7'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'É assim que se faz uma reunião do Heart Team!', 'Inspiracao', '', 'Reels', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 12)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('f92a437f-bacb-5b42-b2d1-4f5ff89fe29d'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Da consulta médica ao Heart Team: como uma conduta fica mais segura', 'Inspiracao', '', 'Carrossel', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 13)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('1c161430-e6ef-5a43-b8ba-0ca794a125dd'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Segunda opinião em valvopatias é sempre necessária?', 'Inspiracao', '', 'Reels', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 14)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('dc7d3ab0-2b2a-56c1-8b87-dd3ae972a91e'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Por que é importante obter uma segunda opinião em valvopatias?', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 15)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('6ca4728e-0cab-564a-90b1-70bb9cbb50aa'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Por que a segunda opinião pode ser uma ato de cuidado', 'Inspiracao', '', 'Carrossel', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 16)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('b8ab9dae-50ef-5686-91ef-0f1020e50fca'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que faz um serviço ser de excelência?', 'Inspiracao', '', 'Carrossel', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 17)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('e8c79db9-4a4e-5b5e-8aa2-d93dcd4beb8f'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Como construir um serviço de excelência em valvopatias?', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 18)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('ed7ae2ae-05e7-584d-a6f1-37c6772a30de'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que queremos que você sinta ao sair da nossa consulta', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 19)
Aprovado na planilha: Sim
Agendado na planilha: Sim
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL, AGENDADO_PLANILHA_SEM_MES'),
  ('d900f1ac-0add-5e53-85e6-f6d3e9bdab40'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O cuidado não termina com o procedimento! (importância do pós-procedimento)', 'Inspiracao, Educacao', 'Geral', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 20)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO, EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('e3a7fb7b-be37-5bc0-8f88-c246d5cc4bb1'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Como se decide o "timing" de uma intervenção em doenças valvares?', 'Inspiracao, Educacao', 'Geral', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 21)
Aprovado na planilha: Sim
Agendado na planilha: Sim
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: INSPIRAÇÃO, EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: AGENDADO_PLANILHA_SEM_MES'),
  ('f80734b7-c12a-5a34-a274-49667927e264'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Tudo que acontece antes do seu procedimento', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 22)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('3656b9e4-7ef8-59a6-b694-e44e6d334ce3'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Bastidores do maior congresso de valvopatias do mundo!', 'Inspiracao', '', 'Reels', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 23)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('4276bc74-a0bb-5b32-8ae4-c06043522069'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que nós fazemos que a IA não consegue fazer/nunca vai conseguir fazer', 'Inspiracao', '', 'Carrossel', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 24)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('75b5d848-5176-5680-ac28-5879177aaa98'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, '22 de fevereiro - abra os olhos e proteja o coração! (Dia de conscientização sobre valvopatias)', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 25)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('2ffd53fb-2ede-5f64-9520-a7f904beafc1'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Profissionais de excelência + centro de alta tecnologia: uma oportunidade ÚNICA de atendimento', 'Inspiracao, Vendas', '', 'Reels', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 26)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO, VENDAS
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('dc6db050-a1cd-50fa-8106-9b2f1a9abda8'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Erros que podem custar caro: diagnósticos corretos, condutas inadequadas', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 27)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('8f7de11d-27c7-5e5c-9e3c-37c3c66e1005'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Meu caso é para tratamento cirúrgico ou percutâneo?', 'Inspiracao', '', 'Carrossel', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 28)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('c9331c2d-6908-53c2-a7d4-a742faec160b'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'X Problemas que não tinham solução, mas agora têm! Como a medicina evoluiu nos últimos anos', 'Inspiracao', '', 'Carrossel', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 29)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('be2f270c-15b7-55db-84ef-d712ad83c56e'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Atendimento centrado no paciente: o que isso significa na prática?', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 30)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('d0edebe7-a2e0-5e6f-9e40-be3b42e20111'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Muitas vezes o que assusta não é a DOENÇA, e sim as DÚVIDAS e INCERTEZAS!', 'Inspiracao', '', 'Carrossel', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 31)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('7eeec1fe-0dac-540e-898d-aed3b147cb51'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Por que a tecnologia de ponta pode ser a diferença entre um desfecho BOM e um EXCELENTE', 'Inspiracao, Vendas', '', 'Reels', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 32)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO, VENDAS
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('842bbfea-5fe7-5fdb-b26d-025350955810'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que nos torna referência quando o assunto é válvula?', 'Inspiracao', '', 'Carrossel', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 33)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('877b21b7-ae81-5d01-97d9-206789aaf18b'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Bastidores do Eco: estrutura da sala, equipamentos, 2D x 3D, Doppler, como faz o exame...', 'Inspiracao', '', 'Reels', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 34)
Aprovado na planilha: Sim
Agendado na planilha: Sim
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL, AGENDADO_PLANILHA_SEM_MES'),
  ('1d0ac4b4-cdb0-5682-91c8-e11b9067e1a0'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Bastidores da hemodinâmica: sala, posicionamento do paciente, acesso, duração...', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 35)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('a076a7af-bcf2-5132-b162-ea11f425eddb'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Bastidores da cirurgia: centro cirúrgico, REPAI, quarto', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 36)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('be4c6b02-984e-53b1-b65c-15994fddf572'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Bastidores dos exames: máquinas de TC/RM, sala de laudos', 'Inspiracao', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 37)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: INSPIRAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('9dc09a67-614e-5592-9561-368d6a485be5'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quizz básico para pacientes (quantas valvas no coração?; Quantos folhetos na mitral/na aórtica?)', 'Entretenimento', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 38)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('c3c09a32-d8b2-52f2-a574-d2f5eaa07fcd'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quizz avançado sobre caso clínico (intervenção X tto clínico; quantificar gravidade...)', 'Entretenimento', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 39)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CARDIOLOGISTAS
Categoria MKT original: ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('0f253f53-ccdf-5c59-86b4-7d5cb985a453'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quizz sobre algum artigo relevante/diretriz em valvopatias', 'Entretenimento', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 40)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('155f26bf-53c4-50b9-ba46-77affa48a8cb'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Perguntas frequentes (tema: nossa equipe e agendamentos)', 'Entretenimento', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 41)
Aprovado na planilha: Sim
Agendado na planilha: Sim
Persona: TODOS
Categoria MKT original: ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL, AGENDADO_PLANILHA_SEM_MES'),
  ('6ced2ce0-f0e7-50ed-94e8-cdda02717914'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, '"Válvula em 1 minuto" (série recorrente): dúvidas reais de pacientes/familiares/outros médicos', 'Entretenimento', '', 'Reels', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 42)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES, CLÍNICOS
Categoria MKT original: ENTRETENIMENTO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('45713bef-38b6-5db1-befd-202aeeda8d20'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, '"Dicionário em valvopatias" (série recorrente): explicando significados/termos importantes', 'Entretenimento', '', 'Carrossel', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 43)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES, CLÍNICOS
Categoria MKT original: ENTRETENIMENTO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('2702776d-f10a-5e6d-b4ff-e2ab6315903a'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quanto o laudo do Eco diz "leve" e você sente que leve não é: o que fazer?', 'Entretenimento', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 44)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('cbaad44b-e8ef-58c8-8d2b-384092732b34'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Aquele momento em que o paciente pergunta "não dá pra esperar um pouco?"', 'Entretenimento', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 45)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('54d61112-593b-57ef-a1ed-04d6bb52271b'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, '"Mas Dra., eu não tenho sopro no coração. Tenho mesmo problema na válvula?"', 'Entretenimento, Educacao', 'Semiologia', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 46)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: ENTRETENIMENTO, EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('9e3a5a0e-9c4f-573b-a78f-9e10adeb6e42'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quem tem valvopatias pode: fazer academia? viajar de avião? tomar diurético?....', 'Entretenimento, Educacao', 'Geral', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 47)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: ENTRETENIMENTO, EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('970899a3-f9aa-5997-9562-ad983bb29630'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'X Sintomas que significam que NÃO está indo bem', 'Entretenimento, Educacao', 'Geral', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 48)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: ENTRETENIMENTO, EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('22f120e0-c2de-5d38-91fd-a6fca3b6ed23'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'X Sinais que NÃO significam "tá tudo bem"', 'Entretenimento, Educacao', 'Geral', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 49)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: ENTRETENIMENTO, EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('c642bb91-19e9-545a-9cdd-8c732d965cad'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'X Perguntas que você DEVE FAZER sobre suas válvulas', 'Entretenimento, Educacao', 'Geral', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 50)
Aprovado na planilha: Sim
Agendado na planilha: Sim
Persona: PACIENTES
Categoria MKT original: ENTRETENIMENTO, EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: AGENDADO_PLANILHA_SEM_MES'),
  ('9ebe0f4c-a3cc-5b82-b278-abf410c3bc06'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Qual a diferença entre "traços" e "jato leve"? Quando isso faz diferença?', 'Educacao', 'Ecocardiograma', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 51)
Aprovado na planilha: Nao
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: NAO_APROVADO_PLANILHA'),
  ('e68f7dcc-9531-5bfa-b388-0940bc07eb1e'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, '"Erros comuns em válvula": confundir "leve" com "não precisa acompanhar", usar exame isolado...', 'Entretenimento, Educacao', 'Geral', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 52)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: ENTRETENIMENTO, EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('16f35fb3-dbf1-5b3f-b5ea-ac8723c05ffe'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, '"Verdadeiro ou falso" sobre válvulas. Tanto versão leigo quanto especialista', 'Entretenimento', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 53)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('228c21ae-e438-53d7-82ba-3fd010c7e0c2'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, '"Nesse caso, você prefere: X versus Y" - formato enquete. Cx versus percutâneo, 3D x Strain...', 'Entretenimento', '', 'Story', 'TOPO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 54)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('3a91490f-ebfa-5781-901e-83b54dc97168'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'X Sinais de Estenose Aórtica que você não pode ignorar', 'Educacao', 'Estenose Aórtica', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 55)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES, CLÍNICOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('b0e88e5d-0c54-546b-b68e-b6b5fe022a37'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Estenose Aórtica sem sintomas existe? TAVI já? Ou dá pra esperar?', 'Educacao', 'Estenose Aórtica', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 56)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES, CLÍNICOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('ae1393ff-ef46-53f6-af87-82fb22cbed09'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'TAVI versus Cirurgia: como se decide?', 'Educacao', 'Estenose Aórtica', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 57)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('44581089-ef1d-584a-820f-ed3092acd799'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Os principais tratamentos da Estenose Aórtica', 'Educacao', 'Estenose Aórtica', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 58)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES, CLÍNICOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('5913d432-0073-58a1-897e-ab2cf2cd225c'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Você é um dos 2% da população que tem VAB? O que é isso e por que isso importa?', 'Educacao', 'Aórtica', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 59)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('6019e0da-533e-5e73-936b-912df28baaf9'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Tratamento preventivo para VAB em jovens: isso já é uma realidade?', 'Educacao', 'Aórtica', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 60)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('6dccce9f-2bc4-5b29-9d5b-808061bf9872'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'TAVI na Insuficiência Aórtica: inovação ou extrapolação?', 'Educacao', 'Insuficiência Aórtica', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 61)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('e62b8d56-aa44-5ef5-bd05-155d87ffc93a'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Como a sua valva aórtica tem que ser? (anatomia, fisiologia)', 'Educacao', 'Aórtica', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 62)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('d774456f-3035-5f3f-bdfb-8b1728a8ca01'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O Eco consegue ver bem a sua valva aórtica? (imagem Eco versus in vivo, na cirurgia)', 'Educacao', 'Aórtica', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 63)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('75d85893-fcdc-57e8-b871-229ee33b018c'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Prolapso da valva mitral: qual a chance de você ter? E de ter que corrigir?', 'Educacao', 'Prolapso Mitral', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 64)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES, CLÍNICOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('b3a99194-3147-5e0a-9cdf-5f08e1f14bf2'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'A diferença entre um prolapso "bom" e um "ruim"', 'Educacao', 'Prolapso Mitral', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 65)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES, CLÍNICOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('da920ec1-845b-52e0-8103-3467c4bd3ce2'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Você já ouviu um sopro cardíaco? (definição e exemplos de sons de diversos sopros)', 'Educacao', 'Semiologia', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 66)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('20793a9d-42f4-5058-bf05-09871ff6c136'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que procedimentos dentários e válvulas têm em comum?', 'Educacao', 'Geral', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 67)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('cc2cceaa-6286-5055-bb69-13f4c12fa00c'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quem se beneficia do TEER?', 'Educacao', 'Mitral', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 68)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('5b3e7f14-5728-574b-a2c6-007f4c13e3be'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'IM degenerativa versus funcional: não é tudo a mesma coisa!', 'Educacao', 'Mitral', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 69)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('cceb801b-d8fc-5a7c-8ec8-4fa10cef9439'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Você consegue dizer a gravidade dessa IM/EM só pelo sopro?', 'Educacao, Entretenimento', 'Mitral', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 70)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO, ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('e349fe2e-3906-5236-8624-a61fb086cd8a'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quando podemos dizer que os sintomas do paciente são por causa da tricúspide?', 'Educacao', 'Tricúspide', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 71)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('d2920efd-2c69-5371-92b7-1b4d49971633'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Sinais de que você têm regurgitação tricúspide (e o que fazer nesses casos)', 'Educacao', 'Tricúspide', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 72)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('074b7926-417b-5a89-a544-1014af18ae0d'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Intervenções percutâneas na tricúspide? Isso já existe?', 'Educacao', 'Tricúspide', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 73)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('e877ccf1-dcbe-56e6-b6b9-deb7f3a9b240'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Implante valvar tricúspide (Lux Valve) - como funciona?', 'Educacao', 'Tricúspide', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 74)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('e1505d14-d41b-5e26-a0ec-406145380994'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que faz o Eco da tricúspide ser desafiador?', 'Educacao', 'Tricúspide', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 75)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('49e80095-a58d-5660-94cd-0b3b5ad20b0c'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Imagem da aorta: quando que o Eco basta e quando pedir uma TC/RM?', 'Educacao', 'Aorta', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 76)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('c30194c9-377b-50fd-8509-8670c89b06ea'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Sopro na região da valva pulmonar: o que pode ser?', 'Educacao', 'Pulmonar', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 77)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('f9092221-a7a0-51b2-b2c4-07dbe0dee89b'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Válvula pulmonar no adulto: quando ela se torna importante?', 'Educacao', 'Pulmonar', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 78)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('37cfa05d-f296-5777-9915-b6e3634c18d1'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que faz da endocardite infecciosa uma urgência diagnóstica', 'Educacao', 'Endocardite', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 79)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('04851cf6-429a-538e-8645-6c740fc9025e'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Qual o risco real de você ter endocardite?', 'Educacao', 'Endocardite', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 80)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('ee71a28d-1d9f-5859-835f-dec1e25bdb9e'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'As principais indicações de profilaxia de endocardite (e quando NÃO fazer!)', 'Educacao', 'Endocardite', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 81)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('f8686e12-c2fa-5e5e-b6e6-bbd165701f7e'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Onde está a endocardite faz a diferença pro tratamento?', 'Educacao', 'Endocardite', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 82)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('f0db1c7c-3a60-5633-9858-f2fe5d4d4d6b'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Vou precisar de cirurgia de troca valvar. E agora, mecânica ou biológica?', 'Educacao', 'Próteses', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 83)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('cdd2a58b-c710-50e9-a266-08f72965af1e'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Toda prótese valvar precisa de anticoagulantes?', 'Educacao', 'Próteses', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 84)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('2069cddd-0aa9-54fa-84bd-38a6b620fb8b'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'A vantagem de ter alguém experiente no Eco intraoperatório da sua cirurgia', 'Educacao', 'Intraoperatório', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 85)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('c1dab8a9-f092-5eb2-82cc-81fd65069c30'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quanto tempo duram as próteses valvares? Como eu sei a hora de trocar?', 'Educacao', 'Próteses', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 86)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('984b8034-d2b2-5c10-88ee-fcac65bacaf9'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Sinais de que sua prótese valvar está degenerada', 'Educacao', 'Próteses', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 87)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('6677ad97-84d3-5531-be6b-ba76e33b9d1d'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Valve-in-valve: uma opção cada vez mais utilizada', 'Educacao', 'Próteses', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 88)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('5c2d84a8-0df7-5531-84ef-f7d0f00e0235'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que você precisa saber sobre anticoagulação para próteses valvares', 'Educacao', 'Próteses', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 89)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('91773c39-4f7d-54b4-ac7e-10e2b257ea1a'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Como a febre reumática vira doença valvar? E como prevenir?', 'Educacao', 'Doença Reumática', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 90)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('acb8afdd-c53d-5fe2-8fac-b75fc63c8f82'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Como tratar a Estenose Mitral Reumática?', 'Educacao', 'Doença Reumática', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 91)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('d5468722-f84b-5a09-bf19-5944f8afe00f'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Gestação e valvopatias: o que precisa estar "ok" antes de engravidar?', 'Educacao', 'Gestação', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 92)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('427df78e-6f89-5bad-a9f5-151f202c24dc'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Desafios do manejo das valvopatias na gestante', 'Educacao', 'Gestação', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 93)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('91461067-b3c2-581a-ab1e-c0282817ec57'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O acontece durante uma troca valvar cirúrgica?', 'Educacao', 'Perioperatório', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 94)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('6cd522cb-9cb9-5b71-9ac2-e64a7aea9cfd'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Plastia ou troca valvar? - uma decisão a ser discutida em equipe', 'Educacao', 'Perioperatório', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 95)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('23cb702a-842a-5ab2-a24e-6d5924fbd31b'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que monitoramos após uma cirurgia de troca valvar?', 'Educacao', 'Perioperatório', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 96)
Aprovado na planilha: Sim
Agendado na planilha: Sim
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: AGENDADO_PLANILHA_SEM_MES'),
  ('ca7e1266-6773-5e87-9bb9-0e99e7b85c07'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que ficar de olho no seu familiar que fez uma cirurgia cardíaca?', 'Educacao', 'Perioperatório', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 97)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('c2efa2c8-e60f-541f-8883-5da78be7f86c'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'EcoTT versus EcoTE - quando cada um é necessário?', 'Educacao, Entretenimento', 'Ecocardiograma', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 98)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO, ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('e903e8c4-8436-50ac-bfbf-386a0abfd767'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Como o Eco 3D pode ser fundamental para o seu coração', 'Educacao', 'Ecocardiograma', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 99)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('1af5a74f-80f1-55c5-8783-fc9a6490a77e'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Strain: você sabe indicar e interpretar?', 'Educacao', 'Ecocardiograma', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 100)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('89857253-facb-54b7-be29-ca8764cd48d3'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Você sabe como funciona o ecocardiograma?', 'Educacao', 'Ecocardiograma', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 101)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('1754df36-6aa8-5d3b-b014-b661ac2a632d'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Essas imagens de Eco 3D fizeram a diferença para o desfecho do paciente!', 'Educacao', 'Ecocardiograma', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 102)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('f12ef7f8-890f-5b20-8a37-e978fbb17511'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'As utilidades da Tomografia Cardíaca nas valvopatias', 'Educacao', 'Outras imagens', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 103)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('614f3923-de1f-5968-8aec-a9dce4ae7310'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Você sabe o papel da Tomografia Cardíaca no preparo da TAVI?', 'Educacao', 'Outras imagens', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 104)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('b8f17c4a-2c4b-5fb0-8645-2941e5f66399'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'A RM Cardíaca faz diferença na avaliação de valvopatias?', 'Educacao', 'Outras imagens', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 105)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('9d47b499-cec5-5e1b-9d3e-9ea952d547e6'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Sizing para TAVI: por que saber QUEM faz o sizing faz a diferença?', 'Educacao', 'Outras imagens', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 106)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('4db8d488-e589-5b23-857f-16f5bf30bfc1'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Falta de ar, cansaço, inchaço... Como identificar sinais de alerta nesses casos?', 'Educacao', 'Semiologia', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 107)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('28aa1b8b-bb66-5e74-920c-78c3dbe6eddc'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Síncope pode ocorrer por causa das válvulas?', 'Educacao', 'Semiologia', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 108)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('b8a51714-df64-532b-98cd-91c503e81fc1'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Sinais para ficar de olho no seu familiar com valvopatia!', 'Educacao', 'Semiologia', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 109)
Aprovado na planilha: Sim
Agendado na planilha: Sim
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: AGENDADO_PLANILHA_SEM_MES'),
  ('df1c9c4f-1e62-592d-b89e-cb3c610e2f00'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O meu smartwatch pode me ajudar a no acompanhamento de valvopatias?', 'Educacao', 'Inovações e Tecnologia', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 110)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('5904679c-2732-5d54-951f-716004e1c6c7'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'IA na imagem cardíaca: quando ela ajuda? E quando ainda não?', 'Educacao', 'Inovações e Tecnologia', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 111)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('a8554595-5ca4-5498-9bbf-f3d55510fa88'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Novos dispositivos para tratamento de valvopatias: como funcionam?', 'Educacao', 'Inovações e Tecnologia', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 112)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('fba395cc-9d54-58aa-ac3f-8057082d6177'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Veja como uma TAVI é aberta!', 'Educacao', 'Inovações e Tecnologia', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 113)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('862a78c5-0c02-558a-99fa-42474455d813'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'É FOP ou CIA? Qual a diferença?', 'Educacao', 'Congênitas', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 114)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('58ce5ecb-83b1-55a2-9db6-921c01bf03cc'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Ter FOP significa que vou ter que fechar?', 'Educacao, Entretenimento', 'Congênitas', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 115)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO, ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('479484e9-d5e6-5b02-bb14-505d58d3309f'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Como é feito o fechamento de um FOP?', 'Educacao', 'Congênitas', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 116)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('b176b282-94d0-5a3c-b9dd-d47cac56ac80'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Os riscos que uma CIA pode trazer ao seu coração', 'Educacao', 'Congênitas', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 117)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('fd5bcb2f-5552-5422-ab74-a11518f9c5be'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Sopro cardíaco é sinônimo de problema. Mito ou verdade?', 'Educacao, Entretenimento', 'Semiologia', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 118)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO, ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('e54dcf2f-6252-5b3e-8e94-fdf3993a23a2'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'TAVI é só para pacientes idosos. Mito ou verdade?', 'Educacao, Entretenimento', 'Percutâneos', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 119)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO, ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('c1cda89f-6231-5f51-ad1c-9652f17ed90d'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quais as diferenças entre os métodos de TEER? (MitraClip versus Pascal)', 'Educacao', 'Percutâneos', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 120)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: CLÍNICOS, CARDIOLOGISTAS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('fd754a31-757f-5960-8011-4871662c13b7'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Qual a vantagem de se fazer uma troca valvar percutânea?', 'Educacao', 'Percutâneos', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 121)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('6d5b1a94-a4b1-595f-8e9e-3e365e2c40ba'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Mitos sobre valvopatias que você precisa conhecer', 'Educacao, Entretenimento', 'Geral', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 122)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO, ENTRETENIMENTO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('1c5f85b8-0a0a-584e-93e4-27d1d121d43c'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, '"Tricúspide não tem como tratar" - estamos em 2026. Será que ainda é assim?', 'Educacao', 'Tricúspide', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 123)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('1cdbb72f-c349-5da1-803c-18b74506a352'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'As próteses valvares duram para sempre?', 'Educacao, Entretenimento', 'Próteses', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 124)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO, ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('77bbc8b8-1abc-506b-81ad-bf2c253ec52d'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que você deve levar para sua avaliação cardiológica?', 'Educacao', 'Geral', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 125)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('7de932ae-1f1c-5914-89d2-03a3d6f2c238'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'De quanto em quanto tempo eu tenho que acompanhar minha doença valvar?', 'Educacao, Entretenimento', 'Geral', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 126)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO, ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('30926522-46cb-5c44-81d8-5f37951af5ef'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Vacinas importantes que protegem inclusive o seu coração!', 'Educacao', 'Geral', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 127)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('6ad83e8d-0882-5929-8dc8-2e7d44892434'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Por que seus hábitos de higiene bucal podem proteger (ou danificar) o seu coração', 'Educacao', 'Endocardite', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 128)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('037b1b19-4796-5c6c-bbb7-14a10f095826'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Pós-procedimento valvar: 5 cuidados, da primeira semana ao primeiro mês', 'Educacao', 'Geral', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 129)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('b5024df3-2f89-589c-920f-87be7c7154be'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Medicamentos que nós, especialistas em valvopatias, não vivemos sem', 'Educacao, Entretenimento', 'Geral', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 130)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO, ENTRETENIMENTO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('2593715c-0637-5fce-bb33-22ffec4d5830'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Piora súbita dos sintomas após procedimento/cirurgia: o que fazer?', 'Educacao', 'Geral', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 131)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('1ba191fa-ccdd-546c-a302-7ebcc0c7c83d'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Valvopatias discretas - e agora? Por quanto tempo eu preciso acompanhar?', 'Educacao', 'Geral', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 132)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('87e69273-a7d9-5e8a-92e0-487f9117ef11'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Minha IM era grave e agora é moderada. Como isso aconteceu? (diferenças de laudos, tempo...)', 'Educacao', 'Geral', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 133)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('a9974f6f-48f3-54c9-aaba-bc66138ab8bb'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Posso fazer atividade física se tenho valvopatia?', 'Educacao, Entretenimento', 'Geral', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 134)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO, ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('90ddd0d9-57e4-5f04-b47c-b39120337b31'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Perguntas importantes a se fazer antes de um procedimento cardíaco', 'Educacao', 'Geral', 'Carrossel', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 135)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('8a2b1bb9-b3dc-5f69-812c-3d1b2016a28f'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quais sintomas são normais após uma cirurgia cardíaca?', 'Educacao', 'Perioperatório', 'Story', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 136)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: PACIENTES
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('05e8314d-71ad-5184-9370-d57205a1b26d'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que significa aparecer um sopro no pós operatório?', 'Educacao', 'Perioperatório', 'Reels', 'MEIO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 137)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: EDUCAÇÃO
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('4ae9924a-7003-58ea-964e-32309aee9a88'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Do sintoma ao pós: nosso acompanhamento valvar é integral', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 138)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('f5f5c60f-9e24-578c-a0ea-0125fb3a21e8'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Sua doença valvar merece um PLANO de cuidado (enaltecer longitudinalidade do serviço)', 'Vendas', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 139)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('c80cd06a-a3e1-5abc-8e34-672f014ac96d'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Um Heart Team focado em valvopatias - decisões mais seguras para casos complexos', 'Vendas', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 140)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('b520092e-0284-5773-8822-b8228141da47'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Segunda opinião em valvopatias: traga maior segurança para seu paciente!', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 141)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('2245197a-3529-5df3-8880-346813bc6920'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Por que válvula tem que ser no Valve Care Center?', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 142)
Aprovado na planilha: Sim
Agendado na planilha: Sim
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL, AGENDADO_PLANILHA_SEM_MES'),
  ('135940cb-2e3e-55e2-9f2e-586cdaeb993a'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Avaliação especializada antes, durante e após a sua TAVI!', 'Vendas', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 143)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('8473a34e-9bc1-53a6-be89-0f6d50baaed9'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quem somos? - Valve Care Center', 'Inspiracao, Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 144)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: INSPIRAÇÃO, VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('ededac61-1c19-5395-997a-15edc48ad154'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Profissionais experientes atuando JUNTOS - como um Heart Team pode transformar sua saúde?', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 145)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('2e8b273a-0700-50eb-a42c-520402d1ed47'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Nosso grupo é único! - Solicite uma segunda opinião em valvopatias', 'Vendas', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 146)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('a75f7f6e-cede-59df-a46e-4ca703280786'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Comunicação clara com o paciente - você sabe o que tem e o que vai fazer', 'Vendas', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 147)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('e9448259-cee1-52c5-ac3b-10d4b3625a01'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Sem idas e vindas desnecessárias - organização para quem vem de fora de Curitiba', 'Vendas', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 148)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('de9a9ecb-d3be-50b1-a7b7-a036f310b057'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Ecocardiograma avançado disponível sempre que necessário - 3D/Strain/Transesofágico', 'Vendas', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 149)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('d89c18f2-651d-58fc-ad57-08ffa567c13f'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Experiências nos maiores centros do Brasil, juntas num centro perto de você!', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 150)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('615a5938-867a-5c83-adc0-9b801541fa61'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que a gente não negocia: segurança, clareza e humanidade', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 151)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('9993dfc1-06cc-5d6b-bed2-92093d9ed426'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Acompanhar a JORNADA (e não apenas o procedimento) é um motivo de ORGULHO para nós!', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 152)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('f6f219b1-718e-59d5-acd4-183a07373c17'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Consulta valvar: agende já! (presencial ou online)', 'Vendas', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 153)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('935a42cb-70b7-5250-ab2e-63ecf065981a'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Precisa de uma segunda opinião para doenças valvares? Marque já pelo link na bio!', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 154)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('b18ab4d8-036b-56c6-b6f1-04bed67e6417'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Faça seu Ecocardiograma Avançado conosco!', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 155)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('732374c7-78e3-5202-924a-03e54a2a4290'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Vai fazer TAVI ou TEER? Marque uma avaliação conosco!', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 156)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('8f128817-0464-5366-a10c-9d3672e01737'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Acompanhe sua prótese valvar conosco!', 'Vendas', '', 'Reels', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 157)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('dd3a4402-5ba0-5c3c-81e0-a2d92ba87d74'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Fecho ou não fecho meu FOP? - Agende uma avaliação conosco!', 'Vendas', '', 'Reels', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 158)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('e7d0f50e-22cc-55dd-bf34-e58d367224e0'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Doenças valvares podem ser silenciosas - não é apenas o sintoma que marca o risco!', 'Vendas, Educacao', 'Geral', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 159)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS, EDUCAÇÃO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('70a1c42f-9f74-568c-a961-b4ae1e959715'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, '"Assintomático" não é o mesmo que "sem progressão" - acompanhe sua doença valvar!', 'Vendas, Educacao', 'Geral', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 160)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS, EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('2e1bc678-15d3-552b-86b2-9e3e08d68002'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Como funciona nossa segunda opinião em valvopatias?', 'Vendas', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 161)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('b8b4cb65-4c63-5a63-9d66-4c5818e4c0a4'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quando que acompanhamento clínico é mais indicado do que intervir?', 'Vendas, Educacao', 'Geral', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 162)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS, EDUCAÇÃO
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: OK'),
  ('2a889961-9409-5d7f-ab23-1caead2b18be'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'O que é uma indicação? Por que ninguém "empurra" intervenções', 'Vendas', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 163)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('fb1a9e97-c32c-5c1d-abdd-ecafad369a75'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Foco em válvulas complementa (e não compete): como podemos agregar à sua saúde?', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 164)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('18b21afc-b7c6-58f1-8e32-0350ec57b253'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Consulta objetiva: o que a gente já resolve no primeiro dia?', 'Vendas', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 165)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('f69e81c3-e7c1-5260-a259-c1926eefa6c1'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Teleconsulta em valvopatias: quando ela pode ser uma opção?', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 166)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('5bd91873-bf39-5b72-b66c-e263b0039ff0'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Quais exames levar na minha primeira consulta?', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 167)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('c2974224-b4d8-5c01-9cf7-0d5bb9d12542'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Perguntas frequentes (tema: planos de saúde atendidos, tempo de consulta, custo exames)', 'Vendas, Entretenimento', '', 'Story', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 168)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS, ENTRETENIMENTO
Formato sugerido original: STORIES
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('d1cd3430-fe2e-5c8d-86ae-662d4985696c'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Depoimentos: "A segunda opinião trouxe mais clareza para meu tratamento!"', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 169)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('206eb01e-804e-56d4-9978-e398f1ed03e3'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Depoimentos: "Foi importante entender o que meu laudo de ecocardiograma dizia!"', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 170)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('157fc178-362e-5ba2-89d2-d0bbe0c8e505'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Depoimentos: "Faço tudo em um lugar só!"', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 171)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('da0a5d3b-94be-5d3f-8394-b267ed4d2621'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Depoimentos: "Acompanhei por um tempo e decidimos intervir no momento certo!"', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 172)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('03523ac7-65ee-5b96-9e41-f0d7e216981d'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Depoimentos: "Agora eu sei os sinais que precisava observar no meu familiar"', 'Vendas', '', 'Carrossel', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 173)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: CARROSSEL
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('68add8f4-b73a-54a0-9b72-55bc8c571fd3'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Perguntas que você deve se fazer antes da consulta (formação/experiência do médico/serviço...)', 'Vendas', '', 'Reels', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 174)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL'),
  ('c361035e-5236-5a9d-8742-9397f7d69a38'::uuid, 'eb9aa951-b915-4b09-9c34-072b56afe4e0'::uuid, 'Não deixe a avaliação da sua doença valvar para depois (mesmo que assintomática!)', 'Vendas', '', 'Reels', 'FUNDO', '—', 'Banco', 'Ideia', 0, 0, NULL, '', 'Fonte: Projeto - Marketing VCC 2026.xlsx > TEMAS (linha 175)
Aprovado na planilha: Sim
Agendado na planilha: Nao
Persona: TODOS
Categoria MKT original: VENDAS
Formato sugerido original: REELS
Tarefas: Nao informado
Autores: Nao informado
Marcadores: INCOMPLETO_OPCIONAL')
ON CONFLICT (id) DO UPDATE SET
  cliente_id      = EXCLUDED.cliente_id,
  titulo          = EXCLUDED.titulo,
  linha           = EXCLUDED.linha,
  subtema         = EXCLUDED.subtema,
  formato         = EXCLUDED.formato,
  funil           = EXCLUDED.funil,
  serie           = EXCLUDED.serie,
  mes             = EXCLUDED.mes,
  status          = EXCLUDED.status,
  likes           = EXCLUDED.likes,
  comentarios     = EXCLUDED.comentarios,
  data_publicacao = EXCLUDED.data_publicacao,
  gancho          = EXCLUDED.gancho,
  orientacoes     = EXCLUDED.orientacoes;

COMMIT;
