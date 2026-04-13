-- =============================================
-- Importação de temas OneHeart para tabela posts
-- Gerado automaticamente
-- Cliente destino: 7463fed9-0bc8-4eea-a7b8-0c5660fee65f
-- Total de registros: 122
-- =============================================

BEGIN;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM clientes WHERE id = '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid) THEN
    RAISE EXCEPTION 'cliente_id % nao encontrado na tabela clientes', '7463fed9-0bc8-4eea-a7b8-0c5660fee65f';
  END IF;
END $$;

-- Atualiza linhas_editoriais da OneHeart
UPDATE clientes SET linhas_editoriais = ARRAY[
  'Prestígio Institucional',
  'Autoridade Técnica em Estruturais',
  'Segurança & Confiança para Pacientes',
  'Encaminhamento Médico & Parceria',
  'Bastidores: Imagem & Heart Team',
  'Casos Comentados',
  'OneHeart Talks! & Ecossistema'
] WHERE id = '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid;

INSERT INTO posts (
  id, cliente_id, titulo, linha, subtema, formato, funil, serie, mes, status,
  likes, comentarios, data_publicacao, gancho, orientacoes
) VALUES
  ('2d13d89e-deaf-5acb-9f98-9d11b9c0bcb1'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Você sabe como escolher um serviço médico de qualidade?',
   'Prestígio Institucional', 'Posicionamento', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'O melhor serviço nem sempre é o mais caro ou o indicado pelo plano. Veja o que realmente importa na hora de escolher.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: INSPIRAÇÃO > Essência
Comentário: citar que o melhor profissional nem sempre é o mais barato ou o que o plano de saúde indica.'),
  ('5c8d6ce7-f023-5cbc-aa2a-ce5bd3ed5b34'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Os congressos mais importantes do mundo da cardiologia intervencionista',
   'Prestígio Institucional', 'Atualização científica', 'Post único', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Onde se define o que há de mais avançado em cardiologia intervencionista — e nós estamos lá.',
   'Persona: MÉDICOS, CLÍNICOS
Cat. original: INSPIRAÇÃO > Essência
Mostrar presença ativa nos principais congressos mundiais (TCT, EuroPCR, ESC, SBC).'),
  ('17389485-f8be-5f2f-993f-901afcfb35b4'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Por que fundamos a OneHeart?',
   'Prestígio Institucional', 'História da OneHeart', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'A OneHeart não nasceu do acaso. Nasceu de uma visão sobre como cuidar melhor dos casos mais complexos.',
   'Persona: TODOS
Cat. original: INSPIRAÇÃO > Essência
Contar a origem da equipe, motivações, visão de cuidado especializado.'),
  ('6b1ebc02-224e-5a02-bc4f-5f9e74461a86'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Quando começamos X Agora',
   'Prestígio Institucional', 'Trajetória OneHeart', 'Post único', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Do início até aqui: uma jornada de casos complexos, aprendizado e resultados que falam por si.',
   'Persona: TODOS
Cat. original: INSPIRAÇÃO > Essência
Mostrar foto antiga dos primeiros dias de hemodinâmica + foto atual citando números da OH.'),
  ('70d08423-514e-5f14-9b42-e5dd6e122f80'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Retrospectiva profissional',
   'Prestígio Institucional', 'Conquistas da equipe', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Diplomas, prêmios, congressos — cada marco construiu a equipe que trata os seus casos hoje.',
   'Persona: TODOS
Cat. original: INSPIRAÇÃO > Essência
Algum membro com diploma importante, prêmio, evento interessante — citando a importância disso para hoje.'),
  ('8a55f13f-d8cc-5934-8874-1cbc246090e0'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Vídeo 4 Valves + entrevista Wilton 06/2025',
   'Bastidores: Imagem & Heart Team', 'Evento', 'Story · Sequência', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Quatro válvulas. Uma conversa técnica que vai direto ao ponto.',
   'Persona: MÉDICOS
Cat. original: INSPIRAÇÃO > Bastidores
Formato: STORIES
Vídeo com entrevista do Dr. Wilton sobre o evento 4 Valves (junho/2025).'),
  ('e35457e1-cd80-5f11-a993-ad326f1be061'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Preparando um sizing para mais uma TAVI',
   'Bastidores: Imagem & Heart Team', 'TAVI, Sizing', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Cada TAVI começa aqui — no planejamento por imagem, antes mesmo de entrar no laboratório.',
   'Persona: MÉDICOS
Cat. original: INSPIRAÇÃO > Bastidores
Mostrar processo de sizing pré-TAVI: análise tomográfica, medidas, seleção de prótese.'),
  ('61baa5af-a5e6-5f27-a3e2-ba19b001d744'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Qual a nossa rotina em um plantão de hemodinâmica?',
   'Bastidores: Imagem & Heart Team', 'Rotina clínica', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Quando o plantão chama, a equipe responde. Um olhar de dentro da hemodinâmica.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: INSPIRAÇÃO > Bastidores
Mostrar rotina do plantão — casos de urgência, preparo, equipe.'),
  ('56adf138-2171-5cda-aa10-1a13673587f4'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Bastidores do Heart Team: como o trabalho em grupo chega a uma conduta?',
   'Bastidores: Imagem & Heart Team', 'Heart Team', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'A conduta mais segura raramente é unilateral. Veja como funciona o nosso Heart Team.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: INSPIRAÇÃO > Bastidores
Mostrar dinâmica de discussão em Heart Team, como diferentes especialidades chegam à melhor conduta.'),
  ('95727ae2-c7ce-5ef9-b2ee-d6055b55c575'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'O que faz um serviço médico ser de excelência?',
   'Prestígio Institucional', 'Posicionamento', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Excelência não é slogan. É critério, tecnologia e equipe alinhados em cada decisão.',
   'Persona: TODOS
Cat. original: INSPIRAÇÃO > Crenças e valores
Explorar todas as qualidades da OneHeart: tecnologia, equipe multidisciplinar, sizing, Heart Team.'),
  ('3b684855-42d4-59b0-bb25-e0090a8fc97c'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como ouvir os pacientes nos faz crescer como profissionais?',
   'Prestígio Institucional', 'Humanização', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'O paciente nos ensina o que nenhum congresso ensina. Uma reflexão que moldou nossa prática.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: INSPIRAÇÃO > Crenças e valores
Formato: Reels. Modelo podcast, falando sem olhar pra câmera.
⚠️ ALERTA CFM (Res. 2.336/2023): depoimento de paciente só é permitido sem citação de resultados individuais, sem nome e sem contexto identificável.'),
  ('411272c8-94a0-57e2-bd00-a5f00b688851'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'O valor da equipe multiprofissional na hemodinâmica',
   'Prestígio Institucional', 'Heart Team', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Nenhum especialista trata uma cardiopatia complexa sozinho. Saiba por que o trabalho em equipe é inegociável.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: INSPIRAÇÃO > Crenças e valores
Explorar o valor da equipe multidisciplinar: hemodinamicista, ecocardiografista, cirurgião, anestesista.'),
  ('ee129093-ed8d-5c2f-8ea8-dbb394dc64f2'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Valores que nos guiam em cada procedimento',
   'Prestígio Institucional', 'Cultura OneHeart', 'Post único', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Antes de qualquer procedimento, há uma decisão criteriosa. Esses são os valores que nos guiam.',
   'Persona: TODOS
Cat. original: INSPIRAÇÃO > Crenças e valores
Listar valores da OneHeart: critério técnico, planejamento, segurança, trabalho em equipe.'),
  ('43cf535e-81c2-5ed1-8f41-1a1aeb18566a'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Mentoria inversa: o que aprendemos com os residentes?',
   'Prestígio Institucional', 'Educação médica', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Ensinar é também aprender. O que os residentes nos ensinaram nos últimos anos.',
   'Persona: MÉDICOS
Cat. original: INSPIRAÇÃO > Crenças e valores
Reflexão sobre ensino e formação de novos hemodinamicistas, cultura de aprendizado contínuo.'),
  ('5bfeb5f7-e82e-557b-9ace-fb7a6f22d7b7'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'A importância de se manter atualizado na medicina',
   'Prestígio Institucional', 'Atualização científica', 'Post único', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Em cardiologia intervencionista, o que era padrão há 5 anos pode não ser mais a melhor opção hoje.',
   'Persona: MÉDICOS
Cat. original: INSPIRAÇÃO > Opiniões
Reflexão sobre a velocidade das mudanças na cardiologia intervencionista e a importância de atualização contínua.'),
  ('d359a079-1d9e-5e39-9225-6ccbd43baa35'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como o Heart Team nos permite oferecer um cuidado melhor aos pacientes?',
   'Bastidores: Imagem & Heart Team', 'Heart Team', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'A decisão mais segura para o paciente nasce de perspectivas que se complementam.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: INSPIRAÇÃO > Opiniões
Mostrar como o Heart Team agrega para a conduta — cada especialidade com sua visão.'),
  ('4a05fea5-8e03-5e36-8727-4898507cfa32'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Qual o impacto da IA na cardiologia intervencionista?',
   'Prestígio Institucional', 'Inovação, IA', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'A inteligência artificial já está transformando a maneira como diagnosticamos e indicamos procedimentos.',
   'Persona: MÉDICOS
Cat. original: INSPIRAÇÃO > Opiniões
Discutir aplicações concretas da IA na cardiologia intervencionista: análise de imagem, sizing, predição de desfechos.'),
  ('eeea02fe-1548-5ddf-973c-de4c473378e4'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Segunda opinião na indicação de procedimentos: o que pensamos?',
   'Encaminhamento Médico & Parceria', 'Indicação', 'Post único', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Segunda opinião não é desconfiança — é critério. E nós incentivamos isso.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: INSPIRAÇÃO > Opiniões
Posicionar a OneHeart como time que apoia a discussão criteriosa e a segunda opinião em casos complexos.'),
  ('56ea18b2-5185-5cd0-81dd-64a79c64b9b3'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   '5 estudos clássicos que mudaram nossa trajetória na hemodinâmica',
   'Prestígio Institucional', 'Evidência científica', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Cinco momentos em que a ciência mudou o que fazemos dentro do laboratório.',
   'Persona: MÉDICOS
Cat. original: INSPIRAÇÃO > Outros
Citar estudos seminais da cardiologia intervencionista estrutural (PARTNER, COAPT, TRILUMINATE, Evolut Low Risk, etc.).
Nota: tema duplicado com ''3 estudos clássicos...'' foi removido; manter apenas este.'),
  ('3a957f92-0282-5287-a9ef-533dbb860951'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'X Características que NÃO queremos ter como hemodinamicistas',
   'Prestígio Institucional', 'Cultura médica', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'O que nos define também é o que nos recusamos a ser.',
   'Persona: MÉDICOS
Cat. original: INSPIRAÇÃO > Outros
Tom reflexivo sobre vícios comuns na prática médica que a OneHeart recusa — falta de critério, arrogância técnica, comunicação ruim.'),
  ('65e231e4-9877-5ce0-a9df-a0b92224346e'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'O que é um médico excelente?',
   'Prestígio Institucional', 'Cultura médica', 'Post único', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Técnica é necessária. Mas não é suficiente para ser excelente.',
   'Persona: TODOS
Cat. original: INSPIRAÇÃO > Outros
Reflexão sobre o que compõe a excelência médica: técnica, comunicação, humanidade, atualização.'),
  ('517e7030-0e50-55ae-9801-cb8269fdd86e'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Uma verdade: a maioria das pessoas não sabe o que faz um hemodinamicista',
   'Segurança & Confiança para Pacientes', 'Educação do paciente', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Você sabe o que faz um hemodinamicista? A maioria não sabe — até precisar de um.',
   'Persona: PACIENTES
Cat. original: INSPIRAÇÃO > Outros
Explicar de forma clara e didática o que é a hemodinâmica e o papel do cardiologista intervencionista.'),
  ('96eeefb4-c5f9-5b96-ac69-c38b2fc7eb65'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Cardiologista intervencionista (hemodinamicista) é cirurgião?',
   'Segurança & Confiança para Pacientes', 'Educação do paciente', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Sem bisturi, sem abertura de tórax — mas tratando doenças cardíacas graves. Entenda o que faz um hemodinamicista.',
   'Persona: PACIENTES
Cat. original: INSPIRAÇÃO > Outros
Explicar diferença entre cirurgia cardíaca e cardiologia intervencionista/hemodinâmica.'),
  ('5102c3ad-949b-5b29-adff-387075fabcb6'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'O que pode te fazer precisar de um cardiologista intervencionista?',
   'Segurança & Confiança para Pacientes', 'Indicação clínica', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Infarto, valvopatia, cardiopatia congênita — situações em que um hemodinamicista pode ser quem faz a diferença.',
   'Persona: PACIENTES
Cat. original: INSPIRAÇÃO > Outros
Listar condições que levam ao encaminhamento para hemodinâmica.'),
  ('7f80dc1c-0ecb-5d49-9a00-d48062d5afb4'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   '2 aplicações da IA na hemodinâmica que fazem parecer que estamos em 2050',
   'Prestígio Institucional', 'Inovação, IA', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'A inteligência artificial já está dentro do laboratório de hemodinâmica. Dois exemplos que você precisa conhecer.',
   'Persona: MÉDICOS
Cat. original: INSPIRAÇÃO > Outros
Citar aplicações concretas e atuais de IA na hemodinâmica (sizing automatizado, análise funcional, IA na angiografia).'),
  ('763d0ae8-ca6e-51f5-84cd-420101965ed2'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Por que discutir um caso em grupo pode ser benéfico para você?',
   'Encaminhamento Médico & Parceria', 'Heart Team, Indicação', 'Post único', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Um único ponto de vista pode não ser suficiente para o caso mais complexo.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: INSPIRAÇÃO > Outros
Falar do benefício da discussão multidisciplinar — especialmente para casos de valvopatia estrutural complexa.'),
  ('104942de-a9e3-5525-8fcb-3f27dc94c8ba'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Arrume-se conosco para um procedimento de X',
   'Bastidores: Imagem & Heart Team', 'Rotina clínica', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Da preparação à sala de hemodinâmica: um procedimento começa muito antes da primeira punção.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: ENTRETENIMENTO > Engajamento
Formato: Reels. Vídeo acelerado mostrando alguém se vestindo, se lavando, colocando avental e luva. Alta chance de engajamento.'),
  ('917c42d7-01be-568b-9bdf-518ad5fd9d39'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Quizz sobre valvas',
   'Segurança & Confiança para Pacientes', 'Válvulas cardíacas', 'Story · Quiz', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'É possível colocar uma válvula nova sem cirurgia? Quantas válvulas temos no coração? Teste seu conhecimento.',
   'Persona: PACIENTES
Cat. original: ENTRETENIMENTO > Engajamento
Formato: STORIES. Quiz interativo sobre válvulas cardíacas.'),
  ('cd7a4d64-b1f0-54b2-a2e5-183a56287b3c'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Quizz sobre IAM/coronárias',
   'Segurança & Confiança para Pacientes', 'IAM, Coronárias', 'Story · Quiz', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Os sintomas de infarto são iguais para homens e mulheres? Você pode se surpreender.',
   'Persona: PACIENTES
Cat. original: ENTRETENIMENTO > Engajamento
Formato: STORIES. Quiz sobre sintomas e mitos do IAM.'),
  ('ffacd9fe-5bdc-57e4-ad3b-1ecf9c2bce11'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Quizz sobre TAVI',
   'Autoridade Técnica em Estruturais', 'TAVI', 'Story · Quiz', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Tamanho X ou Y para este caso? TAVI em estenose moderada ou só grave? Teste seu raciocínio.',
   'Persona: MÉDICOS
Cat. original: ENTRETENIMENTO > Engajamento
Formato: STORIES. Quiz técnico sobre indicação e sizing de TAVI.'),
  ('22b4033e-fd75-5f61-a3e2-749c5f42ea03'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Caixinha de perguntas "tire suas dúvidas cardiológicas antes da sua consulta!"',
   'Segurança & Confiança para Pacientes', 'Educação do paciente', 'Story · Caixinha', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Tem dúvida sobre o seu coração antes da consulta? Manda aqui.',
   'Persona: PACIENTES
Cat. original: ENTRETENIMENTO > Engajamento
Formato: STORIES. Caixinha de perguntas para engajamento com pacientes.'),
  ('f8a65322-9f5b-5102-bee4-2fa4e4d29b54'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como faz pra direcionar o guia pra algum lado específico do vaso?',
   'Autoridade Técnica em Estruturais', 'Técnica intervencionista', 'Reels', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'O guia vai onde o operador quer — mas isso exige critério e técnica. Entenda como.',
   'Persona: MÉDICOS
Cat. original: ENTRETENIMENTO > Perguntas frequentes
Formato: STORIES/CARROSSEL/REELS. Técnica de direcionamento de guia em procedimentos intervencionistas.'),
  ('d8125c78-e3ee-5486-82f6-e496b2fdc8f0'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Quando escolher prótese biológica ou sintética?',
   'Autoridade Técnica em Estruturais', 'Próteses valvares', 'Post único', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Biológica ou mecânica? A escolha não é arbitrária — e depende de fatores que o paciente precisa entender.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: ENTRETENIMENTO > Perguntas frequentes
Critérios para escolha de prótese: idade, fibrilação atrial, anticoagulação, durabilidade.'),
  ('a7b381f2-b5d5-5f95-84fb-4f0425be2b7f'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'O que é melhor, cirurgia ou TAVI?',
   'Segurança & Confiança para Pacientes', 'TAVI, Cirurgia', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Não existe resposta única. Existe a melhor decisão para o caso de cada paciente.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: ENTRETENIMENTO > Perguntas frequentes
Comparar TAVI e cirurgia: indicações, perfil de risco, durabilidade, recuperação.'),
  ('f4cf488b-9558-57df-8b28-13c972b5f8eb'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'O que acontece se injetar álcool no coração? (pra falar de ablação)',
   'Autoridade Técnica em Estruturais', 'Ablação septal, CMH', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Parece drástico — mas a ablação alcoólica septal é uma intervenção precisa e eficaz em situações selecionadas.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: ENTRETENIMENTO > Perguntas frequentes
Explicar ablação alcoólica septal na CMH obstrutiva.'),
  ('c7b9a328-2ee1-5a17-8a27-d1f24e290ac9'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como faz pra chegar no coração? Não vai rasgar/furar os vasos?',
   'Segurança & Confiança para Pacientes', 'Acesso vascular', 'Story · Sequência', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Um cateter chegar ao coração pela artéria do pulso — isso é preciso, minimamente invasivo e seguro.',
   'Persona: PACIENTES
Cat. original: ENTRETENIMENTO > Perguntas frequentes
Explicar acesso radial/femoral e trajeto até o coração de forma didática.'),
  ('8e233dae-3fd8-50e5-8596-7b57c672b95a'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Você sabe o que faz um hemodinamicista?',
   'Segurança & Confiança para Pacientes', 'Educação do paciente', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Médico do coração, mas não cirurgião. Então o que ele faz exatamente?',
   'Persona: PACIENTES
Cat. original: ENTRETENIMENTO > Perguntas frequentes
Explicar de forma didática e visual o papel do cardiologista intervencionista.'),
  ('256873c6-11b8-592b-ad74-edaceb9b5e53'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'O que é sizing?',
   'Bastidores: Imagem & Heart Team', 'Sizing, TAVI', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Sizing não é chute — é ciência aplicada ao tamanho exato da prótese que vai para dentro do seu coração.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: ENTRETENIMENTO > Perguntas frequentes
Explicar o processo de sizing pré-procedimento.'),
  ('efa0a016-eec6-5a3c-9b42-2bcf730f1c8f'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como é feita a desobstrução de uma artéria? (Veja em etapas!)',
   'Segurança & Confiança para Pacientes', 'Angioplastia, IAM', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Uma artéria obstruída. Um cateter. E etapas que salvam vidas. Veja como é feita a angioplastia.',
   'Persona: PACIENTES
Cat. original: ENTRETENIMENTO > Perguntas frequentes
Mostrar passo a passo da angioplastia coronária.'),
  ('5e80f6a7-be18-5ee6-9330-7fddecfe294e'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Dicas pra você dominar o sizing da valva aórtica!',
   'Bastidores: Imagem & Heart Team', 'Sizing, TAVI', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'O sizing correto não é detalhe — é o que separa um procedimento seguro de uma complicação evitável.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > Dicas
Dicas práticas sobre sizing de válvula aórtica para TAVI.'),
  ('27bddfe0-f10b-582e-b41f-0554d8a6069f'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como organizar um Heart Team?',
   'Encaminhamento Médico & Parceria', 'Heart Team', 'Carrossel', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Um Heart Team funcional não se improvisa — aqui estão os elementos que fazem a diferença.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > Dicas
Orientações práticas para estruturar um Heart Team eficiente em cardiopatias estruturais.'),
  ('fa99685c-8ae1-5a5e-9536-51f3ade8e05d'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como se preparar para um cateterismo?',
   'Segurança & Confiança para Pacientes', 'Cateterismo', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Saber o que esperar antes do cateterismo reduz a ansiedade — e melhora a experiência.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > Dicas
Orientações para o paciente antes do cateterismo: jejum, medicamentos, acesso, sedação.'),
  ('ccce5677-513f-543c-8de0-e3a956c4b04e'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Qual o melhor momento de encaminhar o paciente para um cardiologista?',
   'Encaminhamento Médico & Parceria', 'Encaminhamento', 'Carrossel', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Esperar demais tem um custo. Saiba quando o encaminhamento para o especialista é a conduta certa.',
   'Persona: CLÍNICOS
Cat. original: EDUCAÇÃO > Dicas
Critérios para encaminhamento precoce ao cardiologista/hemodinamicista.'),
  ('bf9c6264-5081-5abc-8c64-e2e7b55004e7'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Você sabe indicar/suspender a terapia antitrombótica antes de um procedimento por cateterismo?',
   'Encaminhamento Médico & Parceria', 'Anticoagulação, Pré-procedimento', 'Carrossel', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Anticoagular ou suspender? A resposta depende do procedimento — e a margem de erro é pequena.',
   'Persona: MÉDICOS, CLÍNICOS
Cat. original: EDUCAÇÃO > Dicas
Orientações práticas sobre manejo de antitrombóticos no peri-procedimento.'),
  ('b7bf0581-4c42-5040-9dcf-f7810addf93a'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Quando é indicado ter um ecocardiografista em sala?',
   'Encaminhamento Médico & Parceria', 'Ecocardiografia, Heart Team', 'Post único', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Nem todo procedimento precisa de eco em sala — mas saber quando precisamos é o que distingue segurança de risco.',
   'Persona: MÉDICOS, ECOCARDIOGRAFISTAS
Cat. original: EDUCAÇÃO > Dicas
Indicações de ecocardiografia intraoperatória (ETE) em procedimentos estruturais.'),
  ('5261c096-f5e8-5788-9f7b-ba24cd424cb1'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Leia esses 3 estudos gratuitos e entenda melhor a TAVI!',
   'Autoridade Técnica em Estruturais', 'TAVI, Evidência científica', 'Post único', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Três estudos que definiram como indicamos TAVI hoje. De graça — e essenciais.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > Dicas
Curar 3 estudos fundamentais sobre TAVI (ex: PARTNER 3, Evolut Low Risk, NOTION-3). Incluir links no caption.'),
  ('78109c6d-d0ee-52c4-8155-b7ef819f493e'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Veja por que encaminhar seus pacientes para nós!',
   'Encaminhamento Médico & Parceria', 'Encaminhamento OneHeart', 'Post único', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Critério técnico, planejamento por imagem, Heart Team dedicado. Veja o que o seu paciente ganha com um encaminhamento para a OneHeart.',
   'Persona: MÉDICOS
Cat. original: VENDAS > Vendas
Comunicar diferenciais da OneHeart para médicos encaminhadores: expertise técnica, sizing avançado, Heart Team, comunicação.'),
  ('14a2b864-6f8d-586b-bba1-bef54c9623d8'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Nosso local e horário de atendimento',
   'Prestígio Institucional', 'Localização OneHeart', 'Post único', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Curitiba e região metropolitana. Saiba onde nos encontrar.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: VENDAS > Vendas
Informar localização, hospitais, horários de atendimento. Incluir informações de contato.'),
  ('197d834c-9e70-59bf-ac27-b7324402366a'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Em quem você confia para o atendimento cardiológico da sua família?',
   'Segurança & Confiança para Pacientes', 'Confiança, Posicionamento', 'Reels', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Quando se trata do coração de alguém que você ama, a equipe importa tanto quanto a tecnologia.',
   'Persona: PACIENTES
Cat. original: VENDAS > Vendas
Vídeo curto em câmera lenta, cena de procedimento. Frase sobreposta, seguida pelo logo da OH.'),
  ('af2fd046-e2ac-5ae8-a2d8-16288b0934e5'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Passos para escolher um bom cardiologista',
   'Segurança & Confiança para Pacientes', 'Escolha médica', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Antes de confiar seu coração a um especialista, vale saber o que procurar.',
   'Persona: PACIENTES
Cat. original: VENDAS > Vendas
Orientar pacientes sobre critérios para escolher um cardiologista especializado: experiência, hospital, equipe.'),
  ('c64ab77f-77a7-51e1-bf94-030de173e28d'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Quanto tempo dura uma avaliação/consulta conosco?',
   'Segurança & Confiança para Pacientes', 'Consulta OneHeart', 'Post único', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Uma avaliação criteriosa não tem tempo fixo — tem tempo necessário para cada caso.',
   'Persona: PACIENTES
Cat. original: VENDAS > Vendas
Falar que é variável, dependendo da complexidade do caso. Reforçar atenção aos detalhes, avaliação clínica completa.'),
  ('be470b64-94be-51e1-84a5-b56d70fe0d32'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Números da OneHeart - crescendo a cada dia!',
   'Prestígio Institucional', 'Resultados OneHeart', 'Post único', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Anos de experiência, pacientes atendidos, procedimentos realizados. Os números por trás da OneHeart.',
   'Persona: TODOS
Cat. original: VENDAS > Vendas
Compartilhar métricas de crescimento e experiência da equipe.'),
  ('3387ac7e-c559-5bfa-a2e7-3ae7a426b0a8'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Sua equipe de cardiologistas intervencionistas de confiança!',
   'Prestígio Institucional', 'Equipe OneHeart', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Quem está do outro lado quando o seu coração precisa de intervenção precisa ser de confiança.',
   'Persona: PACIENTES
Cat. original: VENDAS > Vendas
Vídeo curto em câmera lenta, cena de procedimento. Frase sobreposta, seguida pelo logo da OH.'),
  ('bb43b8be-5afe-5fc9-a01e-543cc2ca205b'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Essa é o momento de você conhecer nosso site e nosso canal no YouTube!',
   'Prestígio Institucional', 'Canais digitais OneHeart', 'Post único', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Tudo sobre cardiologia intervencionista — no nosso site e canal do YouTube.',
   'Persona: TODOS
Cat. original: VENDAS > Vendas
Divulgar site e YouTube da OneHeart com chamada para conteúdo técnico.'),
  ('aa213216-622f-579f-88cd-1782ba69f113'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Confira o site OneHeart para aprender mais sobre a cardiologia intervencionista!',
   'Prestígio Institucional', 'Blog OneHeart', 'Post único', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Conteúdo técnico, bem escrito, acessível — está no blog da OneHeart.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: VENDAS > Vendas
Citar publicações do blog. Direcionar para conteúdo específico.'),
  ('98f8295d-e301-54e7-9253-cf0328c43b57'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Mais de 1000 valvas tratadas - excelência como objetivo em cada uma delas',
   'Prestígio Institucional', 'Experiência OneHeart', 'Post único', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Mil valvas tratadas. Mas o que mais importa é que cada uma foi abordada com o mesmo critério.',
   'Persona: TODOS
Cat. original: VENDAS > Vendas
Comunicar experiência em volume e qualidade de procedimentos valvares.'),
  ('deba8f81-b77d-5b53-8527-c01ade9fd183'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Sizing para procedimentos - nós te ensinamos!',
   'Bastidores: Imagem & Heart Team', 'Sizing, Educação médica', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'O sizing que define o desfecho começa com o conhecimento certo. Quer aprender?',
   'Persona: MÉDICOS
Cat. original: VENDAS > Vendas
Divulgar cursos/treinamentos de sizing promovidos pela OneHeart.'),
  ('f1d4c85f-47da-5e65-b6e9-b03fc297df62'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Repost: esses são os planos de saúde que atendemos',
   'Segurança & Confiança para Pacientes', 'Convênios', 'Post único', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Atendemos os principais convênios em Curitiba. Veja se o seu está na lista.',
   'Persona: PACIENTES
Cat. original: VENDAS > Vendas
Listar planos aceitos. Atualizar regularmente.'),
  ('101eeeb2-68c3-5379-8bb0-14e69c325573'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Repost: Cuidados Avançados em Hemodinâmica - seja parceiro OneHeart',
   'Encaminhamento Médico & Parceria', 'Parceria médica', 'Post único', 'FUNDO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Encaminhar com critério começa por conhecer quem vai receber o seu paciente.',
   'Persona: MÉDICOS
Cat. original: VENDAS > Vendas
Convite para médicos encaminhadores — apresentar proposta de parceria assistencial.'),
  ('cc0a2eb1-e1eb-53fc-a2b2-28c4edc02f58'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Conheça a Esthefany Ribaski',
   'Prestígio Institucional', 'Equipe OneHeart', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Por trás de cada consulta bem executada, há alguém que garante que tudo funcione. Conheça a Esthefany.',
   'Persona: TODOS
Cat. original: VENDAS > Vendas
Apresentar Esthefany Ribaski, sua função e como facilita o agendamento.'),
  ('0de883e7-0db4-5579-b98c-80e2b2782fab'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Caso de sucesso: [inserir doença aqui]!',
   'Casos Comentados', 'Caso clínico', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Da indicação ao desfecho: um caso que ilustra por que o planejamento faz toda a diferença.',
   'Persona: MÉDICOS
Cat. original: VENDAS > Resultados
Mostrar quadro clínico, imagens pré/peri/pós.
⚠️ ALERTA CFM (Res. 2.336/2023): proibido foto de paciente identificável, depoimento e linguagem de resultado garantido. Adaptar como raciocínio clínico educativo, sem prometer desfechos.'),
  ('4da8a533-0da4-58d9-9ea3-a61d9b5b7e56'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como pode ser a vida após um TEER bem sucedido?',
   'Segurança & Confiança para Pacientes', 'TEER, Qualidade de vida', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Retornar à rotina em poucos dias após correção valvar — o que os estudos mostram sobre qualidade de vida após TEER.',
   'Persona: PACIENTES
Cat. original: VENDAS > Resultados
Falar de melhora de qualidade de vida e sintomas após TEER. Basear em evidências (COAPT, RESHAPE-HF2). Evitar promessas individuais.'),
  ('18dd32c1-28e3-5c0e-b04e-d8dd27c50a85'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Qual o nosso tempo médio de internamento após uma TAVI?',
   'Prestígio Institucional', 'TAVI, Desfechos', 'Post único', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Alta hospitalar em 24 a 48 horas após TAVI — o que isso significa para o paciente.',
   'Persona: PACIENTES
Cat. original: VENDAS > Resultados
Comunicar desfecho clínico (tempo de internação) baseado em dados da própria equipe ou literatura. Evitar linguagem de promessa.'),
  ('9d4e2d27-c8e1-5acc-90c4-9aa0c73e4712'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Sucesso hemodinâmico: veja em imagens!',
   'Casos Comentados', 'Valvoplastia, Ecocardiografia', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'O que o ecocardiograma mostra antes e depois de uma valvoplastia por balão — em imagens.',
   'Persona: MÉDICOS
Cat. original: VENDAS > Resultados
Eco antes x depois de valvoplastia por balão. Melhora de classe funcional (NYHA 3 para 1).
⚠️ ALERTA CFM (Res. 2.336/2023): imagens pré/pós são permitidas se sem identificação de paciente e sem linguagem comparativa de resultado individual. Usar linguagem técnica.'),
  ('85a13fff-b3bc-5fa1-b1e2-132463110bf2'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Esse foi o número de congressos/eventos que participamos em 2025 (até agora!)',
   'Prestígio Institucional', 'Presença em eventos', 'Post único', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Atualização contínua não é opcional — é o que garante que a OneHeart entrega o que há de mais atual.',
   'Persona: TODOS
Cat. original: VENDAS > Resultados
Mostrar participação como palestrante/convidado em congressos 2025. Reforçar posição de referência na área.'),
  ('3db47eea-70d5-5922-b755-b01bf334437d'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Consulta de retorno 3 anos após TAVI - caso de sucesso!',
   'Casos Comentados', 'TAVI, Follow-up', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Três anos após a TAVI, o paciente retorna com o coração funcionando. O que os dados dizem.',
   'Persona: MÉDICOS
Cat. original: VENDAS > Resultados
Foto com paciente e imagens pós-TAVI mostrando números.
⚠️ ALERTA CFM (Res. 2.336/2023): não identificar paciente; sem linguagem de depoimento ou resultado garantido. Apresentar como dado clínico de follow-up.'),
  ('0030a2fe-7563-5def-b513-28b7d95950fe'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Prolapso da valva mitral: qual a chance de você ter? E de ter que corrigir?',
   'Autoridade Técnica em Estruturais', 'Prolapso mitral, IM', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'O prolapso mitral é mais comum do que parece — mas nem todo caso precisa de intervenção.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: EDUCAÇÃO > MITRAL
Explicar prevalência, risco de ser sintomático, opções de correção e valorizar os procedimentos da OH.'),
  ('e5152813-4700-54c2-bb24-a887adb91944'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Toda IM sintomática precisa de cirurgia ou procedimento transcateter?',
   'Autoridade Técnica em Estruturais', 'Insuficiência mitral', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Insuficiência mitral sintomática não é automaticamente indicação cirúrgica. Entenda o raciocínio.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > MITRAL
Explicar tratamento clínico, opções cirúrgicas e valorizar opções por cateter.'),
  ('91b75b6f-d038-5f76-94f3-75ad230ab943'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'TEER: pelo menos 5 anos de valva firme! - o que dizem os estudos?',
   'Autoridade Técnica em Estruturais', 'TEER, Durabilidade', 'Story · Sequência', 'MEIO', '—',
   'Banco', 'Publicado', 0, 0, NULL,
   'Cinco anos de seguimento. Valva funcionando. Os dados que sustentam a durabilidade do TEER.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > MITRAL
Postado: Sim
Formato: STORIES com link para blog. Incluir dados de estudos COAPT, RESHAPE-HF2.'),
  ('b695354d-3fdf-5d51-b62c-451cd6b6f8ad'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Alta em poucos dias após uma correção valvar! É possível imaginar?',
   'Segurança & Confiança para Pacientes', 'TEER, Recuperação', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Corrigir a válvula mitral e voltar para casa em dias — sem abertura de tórax, sem longa recuperação.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > MITRAL
Explicar o que é TEER, comparar com cirurgia. Frases como ''voltar à rotina sem longa internação''.'),
  ('33921e03-7707-50bb-af61-f205262afb00'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'MitraClip e PASCAL: quais as semelhanças e diferenças?',
   'Autoridade Técnica em Estruturais', 'TEER, Dispositivos', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Dois dispositivos para correção mitral percutânea — mas não são equivalentes. Entenda as diferenças.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > MITRAL
Comparar MitraClip e PASCAL: mecanismo, perfil anatômico, dados de estudos. Pode mostrar vídeo do momento de liberação.'),
  ('5d5d83a3-68a3-5e3f-b178-df6767d2a00d'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como o TEER consegue ser tão revolucionário para o paciente?',
   'Segurança & Confiança para Pacientes', 'TEER', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Minimamente invasivo, duradouro e com alta rápida — o TEER mudou o tratamento da valvopatia mitral.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: EDUCAÇÃO > MITRAL
Explicar TEER, mostrar diferentes técnicas e desfechos: menor internação, durabilidade, segurança, minimamente invasivo.'),
  ('968a5225-d2d4-5d7c-9b59-60cfb62bdd30'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Estenose mitral - existem alternativas por cateterismo ou é só com cirurgia?',
   'Autoridade Técnica em Estruturais', 'Estenose mitral, Valvoplastia', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Para a estenose mitral, o cateter pode ser a resposta — antes mesmo de pensar em cirurgia.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > MITRAL
Falar da valvoplastia mitral percutânea por balão e suas indicações (escore de Wilkins, diretrizes).'),
  ('2de67a46-1098-5e17-9e4f-526d37090eb7'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Insuflar um balão dentro de uma valva que não abre corretamente: O que acontece?',
   'Segurança & Confiança para Pacientes', 'Valvoplastia mitral', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Um balão, uma válvula que não abre — e um alívio imediato dos sintomas. Entenda a valvoplastia mitral percutânea.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > MITRAL
Explicar o princípio da valvoplastia mitral percutânea por balão. Reforçar abordagem minimamente invasiva, recuperação rápida, segurança, ausência de anticoagulantes.'),
  ('917b1751-7ef6-515c-a3ff-12cdf5e6c23e'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Valve in MAC: E quando o cálcio tomou conta da valva. Como proceder?',
   'Autoridade Técnica em Estruturais', 'Valve in MAC, Calcificação', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Quando o cálcio ocupa o anel mitral, as opções convencionais falham. Entenda as soluções percutâneas.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > MITRAL
Explicar o que é MAC (mitral annular calcification) e soluções percutâneas — desafios técnicos.'),
  ('9db042a1-8385-578f-90db-965ccb382548'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Listar os procedimentos, valorizar experiência da equipe, chamar para encaminhamento/avaliação...',
   'Encaminhamento Médico & Parceria', 'Procedimentos mitral', 'Post único', 'FUNDO', '—',
   'Banco', 'Publicado', 0, 0, NULL,
   'Valvoplastia, TEER, Valve-in-Valve — a OneHeart reúne as principais soluções percutâneas para a válvula mitral.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: EDUCAÇÃO > MITRAL
Postado: Sim
Listar procedimentos da valva mitral realizados pela equipe. Chamar para encaminhamento.'),
  ('608ced4b-f782-5074-b2cb-31c6a825ecd9'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   '"Já troquei minha válvula mitral, mas ela está com defeito novamente." Quais as soluções?',
   'Segurança & Confiança para Pacientes', 'Valve in Valve mitral', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Uma prótese mitral com disfunção não significa necessariamente uma nova cirurgia aberta.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > MITRAL
Explicar VIV mitral — indicações, segurança, vantagens do acesso percutâneo.'),
  ('a227b131-a2b8-50e9-88e8-4bf7b5021348'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Quais as diferenças? Valve in Valve, Valve in Ring, Valve in MAC',
   'Autoridade Técnica em Estruturais', 'Valve in Valve, Próteses', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Três situações distintas — mesma lógica percutânea, mas indicações e desafios técnicos diferentes.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > MITRAL
Diferenciar as três modalidades de implante transcateter em estrutura valvar mitral.'),
  ('49721162-bdd8-5fd9-a5c6-3a2779c8fdd8'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Tricúspide: a válvula cardíaca esquecida',
   'Autoridade Técnica em Estruturais', 'Válvula tricúspide', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Por décadas, a válvula tricúspide foi tratada como coadjuvante. A ciência mudou de ideia.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > TRICÚSPIDE
Informações gerais sobre a tricúspide: anatomia, prevalência de doença, impacto clínico.'),
  ('e6685342-c510-5be8-858c-17dfae6a94a1'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Quais as indicações de cirurgia da valva tricúspide? As intervenções percutâneas ficam de lado?',
   'Autoridade Técnica em Estruturais', 'Tricúspide, Indicação', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'O tratamento percutâneo da tricúspide não é mais um horizonte — é uma realidade em casos selecionados.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > TRICÚSPIDE
Informações gerais sobre cirurgia de tricúspide, possibilidade crescente de intervenções percutâneas.'),
  ('d8d6279e-e6ff-5a33-b077-4ba82076d176'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Reparo percutâneo de valva aórtica ou mitral você já conhece. E o reparo da tricúspide? (TriClip)',
   'Autoridade Técnica em Estruturais', 'TriClip, Tricúspide', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'O TriClip trouxe para a tricúspide o que o MitraClip trouxe para a mitral — e os resultados têm surpreendido.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > TRICÚSPIDE
Apresentar o TriClip como extensão da tecnologia TEER para a tricúspide.'),
  ('4d3eb716-fe93-5781-b2db-7360759e96ba'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Desafios e desfechos do reparo percutâneo da tricúspide (TriClip)',
   'Autoridade Técnica em Estruturais', 'TriClip, Desfechos', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'A anatomia da tricúspide impõe desafios únicos. Entenda o que os estudos mostram sobre o TriClip.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > TRICÚSPIDE
Discutir desafios técnicos e dados de desfecho do reparo percutâneo tricuspídeo (TRILUMINATE Pivotal).'),
  ('44c57d72-83de-5606-937b-12e8bd482f72'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Alta tecnologia na TAVI: o que é obrigatório? O que é inútil?',
   'Autoridade Técnica em Estruturais', 'TAVI, Tecnologia', 'Carrossel', 'MEIO', '—',
   'Banco', 'Publicado', 0, 0, NULL,
   'Nem toda tecnologia disponível para TAVI é necessária em todos os casos — saber o que usar é expertise.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > AÓRTICA
Postado: Sim
Diferenciar tecnologias obrigatórias das acessórias na TAVI.'),
  ('6e2741b7-b432-542e-9c3f-2106384cfe0f'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Você tem ideia do quanto de tecnologia se usa em uma TAVI?',
   'Segurança & Confiança para Pacientes', 'TAVI, Tecnologia', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'TC multidetector, fusão de imagem, ecocardiografia 3D — uma TAVI envolve mais tecnologia do que você imagina.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Explicar o que é TAVI, mostrar etapas e tecnologias envolvidas.'),
  ('c4f11016-80aa-50f3-b08a-5a939ff428fb'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como se faz para uma prótese valvar chegar ao coração sem cirurgia?',
   'Segurança & Confiança para Pacientes', 'TAVI', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Uma prótese que viaja pela artéria femoral até o coração — e se abre no lugar exato da válvula antiga.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Mostrar a inserção no cateter e o caminho até o coração, até expansão.'),
  ('94010f1a-ee2f-5b00-ab61-7a329002ff37'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como se troca uma válvula do coração sem abrir o peito?',
   'Segurança & Confiança para Pacientes', 'TAVI', 'Reels', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Trocar uma válvula cardíaca sem cirurgia — parece impossível, mas é o que a TAVI faz.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Foco no contraste com a cirurgia aberta. Mostrar via cateter.'),
  ('17762b29-7af3-5ce4-972c-16ab0bbf013f'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'TAVI: uma solução não cirúrgica para problemas da valva aórtica!',
   'Segurança & Confiança para Pacientes', 'TAVI, Estenose aórtica', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Estenose aórtica grave sem cirurgia — a TAVI já demonstrou ser equivalente ou superior em perfis de risco intermediário e alto.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Explicar o que é TAVI e porque é revolucionária — mostrando desfechos clínicos comparados com cirurgia.'),
  ('033e1f69-5a3a-54ac-8fc9-f11e0db5f03e'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'TAVI: será que é mesmo tão bom quanto uma cirurgia tradicional?',
   'Autoridade Técnica em Estruturais', 'TAVI, Cirurgia', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'A pergunta que todo paciente e muitos cardiologistas se fazem — respondida pelos grandes estudos.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Mostrar desfechos clínicos de TAVI vs cirurgia (mortalidade, AVC, reoperação) baseados em PARTNER, Evolut, etc.'),
  ('7fbc9f55-11d4-53a4-8b5c-70efac14d7c6'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Tipos de TAVI: balão ou autoexpansível?',
   'Autoridade Técnica em Estruturais', 'TAVI, Próteses', 'Reels', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Autoexpansível ou expansível por balão — dois mecanismos distintos, indicações diferentes. Veja como funciona cada um.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > AÓRTICA
Formato: REELS. Comparar próteses balão-expansíveis e autoexpansíveis. Mostrar expansão de cada tipo em vídeo.'),
  ('e7ea6612-ddbe-5534-9a4e-1b0a095cd91b'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Estenose aórtica sem sintomas: TAVI já? Ou dá pra esperar?',
   'Autoridade Técnica em Estruturais', 'TAVI, Estenose aórtica assintomática', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Estenose aórtica grave sem sintomas — quando intervir e quando monitorar. Os estudos recentes mudaram a discussão.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: EDUCAÇÃO > AÓRTICA
Indicações atuais, estudos para populações novas (RECOVERY, AVATAR, estenose assintomática, estenose moderada + disfunção VE).'),
  ('3e1622c2-b1a0-5e7b-91ee-99ea496d679a'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Você saberia dizer para quem a TAVI é indicada?',
   'Segurança & Confiança para Pacientes', 'TAVI, Indicação', 'Story · Enquete', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'TAVI é só para pacientes idosos de alto risco? Ou a indicação já foi além? Descubra.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: EDUCAÇÃO > AÓRTICA
Pode incluir enquete na postagem para engajamento. Atualizar indicações com dados mais recentes.'),
  ('9f315b67-0a2f-5dc2-ba3c-f1da4933ee8d'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'TAVI com excelência: segredos e desafios para o sucesso!',
   'Bastidores: Imagem & Heart Team', 'TAVI, Sizing, Heart Team', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Uma TAVI bem indicada, bem planejada e bem executada é o resultado de um sistema — não de um gesto técnico isolado.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Desde indicação precisa, sizing (chamar pro curso), procedimento em si, equipe qualificada. Citar características da OneHeart.'),
  ('c5a1ea96-f509-5560-be1f-d676c35b46db'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Podemos indicar TAVI numa valva bicúspide?',
   'Autoridade Técnica em Estruturais', 'TAVI, Valva bicúspide', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'A valva bicúspide é um desafio para a TAVI — mas não é mais uma contraindicação absoluta.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Desafios técnicos da TAVI em VAB: sizing, anchoring, TAVI-in-TAVI futuro.'),
  ('8d170942-be81-543c-8ffc-e8ee6c1790d4'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   '"Já fiz cirurgia de troca valvar, mas a valva voltou a fechar. Vou ter que reoperar?"',
   'Segurança & Confiança para Pacientes', 'Valve in Valve aórtico', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Uma prótese cirúrgica com disfunção — e a solução pode estar no cateter, não em uma nova cirurgia.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Valve in valve aórtico — indicações, segurança, vantagens percutâneas.'),
  ('0a3583ae-cf6e-54ac-87c5-a17c2be4eeb9'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Valve-in-valve: quem é o melhor candidato?',
   'Autoridade Técnica em Estruturais', 'Valve in Valve', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Nem toda disfunção de prótese aórtica é candidata ao Valve-in-Valve. Saiba os critérios.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Critérios de seleção para VIV aórtico.'),
  ('be793695-f90c-59d1-b936-0d8cb4cdc619'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Já imaginou colocar uma prótese por cateter numa válvula já operada? Não é mais fácil refazer a cirurgia?',
   'Segurança & Confiança para Pacientes', 'Valve in Valve', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Colocar uma nova prótese dentro da antiga — sem abrir o tórax novamente. Entenda o Valve-in-Valve.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Explicar VIV de forma didática, mostrando o benefício da abordagem percutânea em relação à reoperação.'),
  ('9d3a52df-e0e8-5c28-8ada-41e49831588f'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'TAVI versus cirurgia: os números mais atuais',
   'Autoridade Técnica em Estruturais', 'TAVI, Cirurgia, Evidência', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Os dados mais recentes sobre TAVI versus cirurgia — o que mudou nas últimas diretrizes.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Dados de mortalidade, AVC, implante de marcapasso, durabilidade (PARTNER 3, Evolut Low Risk, NOTION-3).'),
  ('a4bc2a05-6c0e-5da0-9791-ea49790ceae5'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'TAVI versus cirurgia: riscos em curto, médio e longo prazo',
   'Autoridade Técnica em Estruturais', 'TAVI, Cirurgia, Risco', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Os riscos não são iguais para TAVI e cirurgia — e variam conforme o tempo de seguimento.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Comparar perfil de risco de TAVI e cirurgia em curto, médio e longo prazo.'),
  ('accd03a7-e2e5-5bf2-9697-a3db03b393ba'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'TAVI versus cirurgia: durabilidade',
   'Autoridade Técnica em Estruturais', 'TAVI, Durabilidade', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Quanto tempo dura uma TAVI? A durabilidade é o principal argumento de quem ainda prefere a cirurgia.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Dados de durabilidade de TAVI e cirurgia. Discutir follow-up de 5, 8 e 10 anos.'),
  ('3d4f0ecb-1974-5763-8ed7-8cf46f19c59d'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Coloquei uma TAVI há 5 anos. Será que vou precisar refazer? O que devo saber sobre a durabilidade?',
   'Segurança & Confiança para Pacientes', 'TAVI, Follow-up, Durabilidade', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Cinco anos após a TAVI — o que monitorar, o que esperar e quando se preocupar.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Responder de forma didática sobre durabilidade e follow-up pós-TAVI.'),
  ('b2e58d35-e143-5dec-be44-a6b81cb8a273'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Fast-track TAVI - alta em 24 horas?!',
   'Segurança & Confiança para Pacientes', 'TAVI, Recuperação', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Alta em 24 horas após TAVI não é descuido — é o resultado de planejamento preciso e tecnologia avançada.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: EDUCAÇÃO > AÓRTICA
Explicar protocolo fast-track TAVI: seleção, anestesia, abordagem, follow-up precoce.'),
  ('d497ab00-baf3-5d43-9e10-dc76604d00e1'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Complicações após TAVI: mitos e verdades que você precisa saber',
   'Autoridade Técnica em Estruturais', 'TAVI, Complicações', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Bloqueio de ramo, paravalvar leak, AVC — o que são, qual a frequência real e o que mudou com a evolução técnica.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Desmistificar complicações da TAVI com dados atualizados.'),
  ('a5dabfa9-97a7-50c5-9d27-10d0e6c94778'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Valvoplastia aórtica com balão: quando, como, por que e pra quem?',
   'Autoridade Técnica em Estruturais', 'Valvoplastia aórtica', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Antes da TAVI ou como ponte para a decisão — a valvoplastia aórtica por balão ainda tem seu lugar.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Indicações, técnica e resultados da valvoplastia aórtica por balão.'),
  ('b0e7470f-41e2-5e8a-82ee-9d242632b7f4'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'TAVI na insuficiência aórtica: inovação ou extrapolação?',
   'Autoridade Técnica em Estruturais', 'TAVI, Insuficiência aórtica', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'TAVI foi desenhada para estenose aórtica — mas a insuficiência aórtica pura vem sendo tratada percutaneamente.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > AÓRTICA
Discutir TAVI em insuficiência aórtica pura: anatomia, desafios, dispositivos dedicados, dados iniciais.'),
  ('24fef6bb-1851-554b-a219-75d88188a00a'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   '2% da população tem VAB! O que é? Quem tem mais chances?',
   'Autoridade Técnica em Estruturais', 'Valva aórtica bicúspide', 'Post único', 'TOPO', '—',
   'Banco', 'Publicado', 0, 0, NULL,
   'A alteração cardíaca congênita mais comum — e muita gente nunca ouviu falar.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Postado: Sim
Falar sobre VAB: prevalência, riscos ao longo da vida, possibilidades de tratamento. CHAMADA PARA POST BLOG.'),
  ('0bdb6c1b-318d-58a4-a91a-2846e0a667b6'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Tratamento preventivo para VAB em jovens. Isso já é uma realidade?',
   'Autoridade Técnica em Estruturais', 'Valva aórtica bicúspide, Prevenção', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Intervir em jovens com VAB antes dos sintomas — o que as evidências mais recentes dizem sobre isso.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Discutir indicação precoce de intervenção na VAB em pacientes jovens assintomáticos.'),
  ('23054358-8d9e-5e6b-901c-3baf9d6ea8ef'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Estenose aórtica - quais são os sintomas? Precisa tratar?',
   'Segurança & Confiança para Pacientes', 'Estenose aórtica', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Falta de ar, tontura, dor no peito — sintomas que podem ser da válvula aórtica e que não devem ser ignorados.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > AÓRTICA
Explicar sintomas, citar 1-2 estudos e mostrar benefício do tratamento.'),
  ('2098c275-8628-5c23-9fe2-ea23c28f45e4'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como escolhemos o tamanho dessa prótese de TAVI? - Um caso de sizing',
   'Bastidores: Imagem & Heart Team', 'Sizing TAVI, Caso clínico', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Da tomografia à escolha da prótese — veja como funciona o sizing que define o sucesso de uma TAVI.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > AÓRTICA
Caso real de sizing de TAVI: análise TC, medidas, seleção de prótese.
⚠️ Sem identificação de paciente (Res. 2.336/2023).'),
  ('3dc28b52-de73-53ad-b01b-dfe76a8df93f'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Infarto: do fechamento à abertura do vaso. Qual deve ser o caminho?',
   'Autoridade Técnica em Estruturais', 'IAM, Angioplastia primária', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Cada minuto conta durante um infarto — o caminho do fechamento arterial ao stent aberto define o desfecho.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: EDUCAÇÃO > CORONÁRIA
Pontos-chave do tratamento ideal do IAM: procura precoce, ECG, coronariografia, angioplastia.'),
  ('71738ab8-7cb9-57b2-9c49-fa0605b15e6f'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'O que são os famosos "stents" utilizados na angioplastia?',
   'Segurança & Confiança para Pacientes', 'Angioplastia, Stents', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Você já ouviu falar de stent — mas sabe o que ele é e por que muda tudo no tratamento do infarto?',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > CORONÁRIA
Explicar o que é angioplastia, o que é infarto e o que são os stents e suas diferenças.'),
  ('4c60ab0d-e1e6-57cc-a6b0-b6c771ada519'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Entenda como sua artéria fecha durante um infarto!',
   'Segurança & Confiança para Pacientes', 'IAM, Fisiopatologia', 'Carrossel', 'TOPO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Uma placa que rompe, um coágulo que se forma, uma artéria que fecha — entenda como o infarto acontece.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > CORONÁRIA
Explicar o que causa o IAM (fisiopatologia + fatores de risco) de forma visual.'),
  ('2e2a9478-66fb-5347-969e-dd46ed4cacde'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Acesso radial versus femoral - qual a diferença? Existe um preferido?',
   'Autoridade Técnica em Estruturais', 'Acesso vascular', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Pelo punho ou pela virilha — a escolha do acesso impacta conforto, segurança e recuperação.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: EDUCAÇÃO > CORONÁRIA
Comparar acesso radial e femoral em procedimentos intervencionistas.'),
  ('87788473-8b20-5f59-bfa5-8c9b7a4c4c96'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'O que vemos no ECG antes, durante e depois de um IAM?',
   'Autoridade Técnica em Estruturais', 'IAM, ECG', 'Post único', 'MEIO', '—',
   'Banco', 'Publicado', 0, 0, NULL,
   'O ECG conta a história do infarto — fase a fase. Saiba interpretar cada mudança.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > CORONÁRIA
Postado: Sim
Mostrar 1 complexo PQRST de cada fase, junto com foto da artéria aberta > fechada > com stent.'),
  ('ddb14e9d-4849-5ebe-8f04-8b78091142f7'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Existe infarto sem obstrução das coronárias?',
   'Autoridade Técnica em Estruturais', 'MINOCA', 'Carrossel', 'MEIO', '—',
   'Banco', 'Publicado', 0, 0, NULL,
   'MINOCA — infarto sem obstrução coronária. Mais comum do que se pensa, e frequentemente subdiagnosticado.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > CORONÁRIA
Postado: Sim (tema precisava de ajustes)
Definir infarto, falar de MINOCA e diagnósticos diferenciais.'),
  ('bc59a79c-c4bf-5f82-bcf7-77bfbc5af306'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Qual deve ser o tempo porta-balão no IAM?',
   'Autoridade Técnica em Estruturais', 'IAM, Tempo porta-balão', 'Post único', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   '90 minutos ou menos — por que o tempo porta-balão no IAM é uma métrica de qualidade assistencial.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > CORONÁRIA
Explicar o conceito, a meta de 90 minutos e o impacto no desfecho.'),
  ('9b9c6442-3813-5b89-83d5-4d558dee5898'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Desafios que encontramos no tratamento com stents',
   'Autoridade Técnica em Estruturais', 'Angioplastia, Stents', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Óstios, bifurcações, calcificações severas — situações que exigem mais do que técnica básica em angioplastia.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: EDUCAÇÃO > CORONÁRIA
Falar de antiplaquetários, obstruções em locais difíceis (óstios, bifurcações, enxertos, placas calcificadas).'),
  ('0fac2330-e0dc-5ef4-bbd4-7a95fd7e58d7'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Quando usamos IVUS e OCT? Tecnologias de ponta no tratamento das coronárias',
   'Autoridade Técnica em Estruturais', 'IVUS, OCT, Imageamento intracoronário', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Ver por dentro da artéria — o imageamento intracoronário mudou como fazemos angioplastia.',
   'Persona: MÉDICOS
Cat. original: EDUCAÇÃO > CORONÁRIA
Explicar IVUS e OCT: quando indicar, o que cada um oferece, impacto no resultado.'),
  ('1b5a22b2-b199-5bf4-b17c-7597d81275fe'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Toda placa encontrada nas artérias deve ser tratada com stents?',
   'Autoridade Técnica em Estruturais', 'DAC, FFR, Indicação', 'Post único', 'MEIO', '—',
   'Banco', 'Publicado', 0, 0, NULL,
   'Nem toda placa que aparece no cateterismo precisa de stent — e intervir sem indicação correta tem custo.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: EDUCAÇÃO > CORONÁRIA
Postado: Sim
Falar de FFR, iFR e outros índices fisiológicos para guiar revascularização.'),
  ('a88bbb13-e682-54f2-93f7-103491524368'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Stents também podem ter complicações! Como elas são tratadas?',
   'Autoridade Técnica em Estruturais', 'Stents, Complicações', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Trombose de stent, reestenose — complicações que existem e que exigem manejo especializado.',
   'Persona: PACIENTES, MÉDICOS
Cat. original: EDUCAÇÃO > CORONÁRIA
Falar das complicações e valorizar a qualidade técnica do implante primário do stent.'),
  ('e8ec1a2b-4052-5504-bb22-e0843820c948'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Qual a sua chance de ter um forame oval patente?',
   'Autoridade Técnica em Estruturais', 'FOP, Cardiopatias congênitas', 'Story · Sequência', 'TOPO', '—',
   'Banco', 'Publicado', 0, 0, NULL,
   'Uma em cada quatro pessoas tem FOP. A maioria nunca vai saber — até virar um achado relevante.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > CONGÊNITAS
Postado: Sim
Formato: STORIES com link para blog. FOP: prevalência, quando tratar, fechamento percutâneo.'),
  ('6d7d2474-350f-55f2-88f2-360acef2bd49'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'O que exatamente é a sedação durante os procedimentos? Eu não sinto dor?',
   'Segurança & Confiança para Pacientes', 'Sedação, Pré-procedimento', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'Não é anestesia geral, mas você não vai sentir dor — entenda como funciona a sedação nos nossos procedimentos.',
   'Persona: PACIENTES
Cat. original: EDUCAÇÃO > GERAL
Explicar sedação consciente em procedimentos intervencionistas: conforto, segurança, diferença de anestesia geral.'),
  ('992b8466-d9ae-5a29-87be-d8b009eab038'::uuid, '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid,
   'Como um Heart Team pode fazer a diferença no desfecho do paciente?',
   'Bastidores: Imagem & Heart Team', 'Heart Team', 'Carrossel', 'MEIO', '—',
   'Banco', 'Ideia', 0, 0, NULL,
   'A melhor conduta nasce de perspectivas múltiplas. Saiba como o Heart Team muda os desfechos.',
   'Persona: MÉDICOS, PACIENTES
Cat. original: EDUCAÇÃO > GERAL
Discutir o papel do Heart Team nas cardiopatias estruturais complexas.');

COMMIT;

-- Verificação: deve retornar 122 linhas
-- SELECT COUNT(*) FROM posts WHERE cliente_id = '7463fed9-0bc8-4eea-a7b8-0c5660fee65f'::uuid;