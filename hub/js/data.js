/* =============================================
   DATA.JS — Constantes e estrutura do hub
   Carregado antes de ui.js, app.js e mes.js
   Os arrays CLIENTES e POSTS são populados pelo
   Supabase via db.js — não há mais dados fictícios.
   ============================================= */

const MESES_ANO = [
  "Janeiro","Fevereiro","Março","Abril","Maio","Junho",
  "Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"
];

const LINHAS = [
  "Medicina do Estilo de Vida",
  "Conversão",
  "Causa & Conscientização",
  "Humanização"
];

const FORMATOS = ["Reels", "Carrossel", "Post único", "Story · Enquete", "Story · Quiz", "Story · Caixinha", "Story · Slider", "Story · Sequência"];
const FUNIS    = ["TOPO", "MEIO", "FUNDO"];
const STATUS   = ["Ideia", "Roteiro", "Gravado", "Editado", "Publicado"];
const SERIES   = ["—", "Mito ou Verdade? 🫀", "Pergunte à Dra."];

/* -----------------------------------------------
   ARRAYS EM MEMÓRIA (populados pelo Supabase)
----------------------------------------------- */
const CLIENTES = []; // preenchido por db.fetchClientes() no DOMContentLoaded
const POSTS    = []; // preenchido por db.fetchPosts(clienteId) ao selecionar cliente

/* -----------------------------------------------
   DADOS FICTÍCIOS — mantidos abaixo apenas como
   referência de estrutura, não são mais usados.
   Serão removidos na limpeza final do projeto.
----------------------------------------------- */
const _CLIENTES_FICTICIO_REF = [
  {
    id: "paola",
    nome: "Paôla Cardoso Preto",
    handle: "@paolapreto",
    especialidade: "Cardiologia — IC Avançada & Transplante",
    avatar: "🫀",
    seguidores: 1599,
    posts_publicados: 130,
    meta_posts_mes: 4,
    ano: 2026,
    meses_ativos: ["Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"]
  },
  {
    id: "rafael",
    nome: "Dr. Rafael Mendes",
    handle: "@drrafaelmendes",
    especialidade: "Ortopedia & Medicina Esportiva",
    avatar: "🦴",
    seguidores: 3240,
    posts_publicados: 87,
    meta_posts_mes: 3,
    ano: 2026,
    meses_ativos: ["Janeiro","Fevereiro","Março","Abril","Maio","Junho",
                   "Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"]
  },
  {
    id: "ana",
    nome: "Dra. Ana Beatriz Costa",
    handle: "@anabeacosta",
    especialidade: "Dermatologia & Estética",
    avatar: "✨",
    seguidores: 8750,
    posts_publicados: 312,
    meta_posts_mes: 5,
    ano: 2026,
    meses_ativos: ["Janeiro","Fevereiro","Março","Abril","Maio","Junho",
                   "Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"]
  }
];

const _POSTS_FICTICIO_REF = [
  /* ---- PAÔLA (12 posts) ---- */
  {
    id:"post-1", clienteId:"paola",
    titulo:"Checkup cardiovascular: quem precisa e quando fazer",
    linha:"Medicina do Estilo de Vida", subtema:"Prevenção",
    formato:"Carrossel", funil:"TOPO", serie:"—", mes:"Abril",
    status:"Publicado", likes:187, comentarios:22,
    data_publicacao:"2026-04-07",
    gancho:"Você faz checkup todo ano? A maioria espera sentir algo — e esse é o erro.",
    orientacoes:"Carrossel 6 slides. Slide 1: pergunta. Slides 2-5: quem precisa, exames básicos. Slide 6: CTA agendar."
  },
  {
    id:"post-2", clienteId:"paola",
    titulo:"MAPA: quando a pressão no consultório engana",
    linha:"Medicina do Estilo de Vida", subtema:"Exames",
    formato:"Reels", funil:"MEIO", serie:"—", mes:"Abril",
    status:"Publicado", likes:312, comentarios:41,
    data_publicacao:"2026-04-14",
    gancho:"Sua pressão está normal no consultório — mas e no trânsito? No trabalho? No sono?",
    orientacoes:"Reels ≤60s. Mostrar aparelho de MAPA. Explicar hipertensão mascarada."
  },
  {
    id:"post-3", clienteId:"paola",
    titulo:"Apresentação — nova fase em São Paulo",
    linha:"Conversão", subtema:"Apresentação",
    formato:"Post único", funil:"FUNDO", serie:"—", mes:"Abril",
    status:"Publicado", likes:245, comentarios:58,
    data_publicacao:"2026-04-01",
    gancho:"Meu nome é Paôla Cardoso Preto e eu cuido de corações que precisam de especialização.",
    orientacoes:"Post de apresentação. Foto profissional. Mencionar Einstein, São Luiz Itaim e Dante Pazzanese."
  },
  {
    id:"post-4", clienteId:"paola",
    titulo:"Saúde cardiovascular da mulher — o que muda após os 40",
    linha:"Medicina do Estilo de Vida", subtema:"Fatores de Risco",
    formato:"Carrossel", funil:"TOPO", serie:"—", mes:"Maio",
    status:"Editado", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"O estrogênio protege o coração da mulher — até deixar de proteger. E aí?",
    orientacoes:"Carrossel 7 slides. Foco em menopausa e risco cardiovascular. CTA: salvar e compartilhar."
  },
  {
    id:"post-5", clienteId:"paola",
    titulo:"Por que cardiologista prescreve exercício?",
    linha:"Medicina do Estilo de Vida", subtema:"Exercício Físico",
    formato:"Reels", funil:"TOPO", serie:"—", mes:"Junho",
    status:"Roteiro", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"Exercício não é sugestão de estilo de vida. É prescrição médica.",
    orientacoes:"Reels dinâmico. Dados sobre VO2max. Mostrar diferentes tipos de exercício."
  },
  {
    id:"post-6", clienteId:"paola",
    titulo:"VO2max: o número que prevê sua longevidade",
    linha:"Medicina do Estilo de Vida", subtema:"Exercício Físico",
    formato:"Carrossel", funil:"MEIO", serie:"—", mes:"Junho",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"1 número prevê melhor sua longevidade do que colesterol, pressão ou glicemia. Qual é?",
    orientacoes:"Explicar VO2max de forma leiga. Tabela de referência por faixa etária."
  },
  {
    id:"post-7", clienteId:"paola",
    titulo:"IC avançada: o Quarteto Fantástico que salva vidas",
    linha:"Medicina do Estilo de Vida", subtema:"Doença/Condição",
    formato:"Carrossel", funil:"MEIO", serie:"—", mes:"Julho",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"4 medicamentos mudaram completamente o prognóstico da insuficiência cardíaca. Você conhece?",
    orientacoes:"Explicar o Quarteto Fantástico de forma acessível. Não mencionar nomes de remédios sem contextualizar."
  },
  {
    id:"post-8", clienteId:"paola",
    titulo:"Sono e coração: dormir mal é fator de risco",
    linha:"Medicina do Estilo de Vida", subtema:"Sono",
    formato:"Reels", funil:"TOPO", serie:"Mito ou Verdade? 🫀", mes:"Agosto",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"7 a 9 horas. Não é luxo — é cardioprevenção.",
    orientacoes:"Formato Mito ou Verdade. Mitos: dormir pouco é sinal de produtividade, cochilos compensam."
  },
  {
    id:"post-9", clienteId:"paola",
    titulo:"Abertura Mês do Coração — dados que assustam e motivam",
    linha:"Causa & Conscientização", subtema:"Dados Epidemiológicos",
    formato:"Post único", funil:"TOPO", serie:"—", mes:"Setembro",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"1 em cada 3 mortes no Brasil é por doença cardiovascular. Isso não precisa ser assim.",
    orientacoes:"Post de abertura do Mês do Coração. Dados do SVS/MS. Cor: usar identidade do mês."
  },
  {
    id:"post-10", clienteId:"paola",
    titulo:"27/set — Dia Nacional da Doação de Órgãos",
    linha:"Causa & Conscientização", subtema:"Doação de Órgãos",
    formato:"Post único", funil:"TOPO", serie:"—", mes:"Setembro",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"Você é doador? Uma decisão sua pode salvar até 8 vidas.",
    orientacoes:"Post institucional. Muito impacto emocional. Incentivar conversa em família."
  },
  {
    id:"post-11", clienteId:"paola",
    titulo:"Tabagismo e coração: o que acontece no primeiro cigarro",
    linha:"Medicina do Estilo de Vida", subtema:"Fatores de Risco",
    formato:"Carrossel", funil:"TOPO", serie:"—", mes:"Novembro",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"O primeiro cigarro do dia dispara em menos de 10 minutos. O coração sente.",
    orientacoes:"Carrossel educativo. Dados sobre vasoconstrição, risco de infarto em fumantes."
  },
  {
    id:"post-12", clienteId:"paola",
    titulo:"Agende seu checkup para 2027",
    linha:"Conversão", subtema:"Agendamento",
    formato:"Post único", funil:"FUNDO", serie:"—", mes:"Dezembro",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"O melhor presente de fim de ano? Cuidar do seu coração antes que ele precise pedir.",
    orientacoes:"Post de encerramento do ano. CTA forte para agendamento. Mencionar os três hospitais."
  },

  /* ---- RAFAEL (8 posts) ---- */
  {
    id:"post-20", clienteId:"rafael",
    titulo:"Joelho: quando operar e quando esperar?",
    linha:"Medicina do Estilo de Vida", subtema:"Doença/Condição",
    formato:"Carrossel", funil:"MEIO", serie:"—", mes:"Janeiro",
    status:"Publicado", likes:521, comentarios:87,
    data_publicacao:"2026-01-15",
    gancho:"A maioria dos pacientes que chega pedindo cirurgia no joelho não precisa operar. Mas alguns sim.",
    orientacoes:"Carrossel com critérios clínicos. Linguagem leiga. Evitar jargão ortopédico."
  },
  {
    id:"post-21", clienteId:"rafael",
    titulo:"Retorno ao esporte após lesão: o erro mais comum",
    linha:"Medicina do Estilo de Vida", subtema:"Exercício Físico",
    formato:"Reels", funil:"TOPO", serie:"—", mes:"Janeiro",
    status:"Publicado", likes:893, comentarios:134,
    data_publicacao:"2026-01-22",
    gancho:"Voltou rápido demais. A dor sumiu, mas a lesão não cicatrizou.",
    orientacoes:"Reels com linguagem motivacional. Dar critérios objetivos de retorno."
  },
  {
    id:"post-22", clienteId:"rafael",
    titulo:"Ombro: os 3 tendões que mais lesionam em atletas",
    linha:"Medicina do Estilo de Vida", subtema:"Doença/Condição",
    formato:"Carrossel", funil:"TOPO", serie:"—", mes:"Fevereiro",
    status:"Publicado", likes:344, comentarios:29,
    data_publicacao:"2026-02-10",
    gancho:"Natação, vôlei, crossfit — o ombro paga o preço. Veja quais são as lesões mais comuns.",
    orientacoes:"Carrossel anatômico simplificado. Usar ilustrações se possível."
  },
  {
    id:"post-23", clienteId:"rafael",
    titulo:"Corrida: dor no joelho não é normal",
    linha:"Medicina do Estilo de Vida", subtema:"Exercício Físico",
    formato:"Reels", funil:"TOPO", serie:"Mito ou Verdade? 🫀", mes:"Março",
    status:"Editado", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"'É normal doer quando você está começando a correr.' Mito ou verdade?",
    orientacoes:"Formato Mito ou Verdade. Resposta: MITO. Explicar síndrome patelofemoral."
  },
  {
    id:"post-24", clienteId:"rafael",
    titulo:"Onde atendo e como agendar sua consulta",
    linha:"Conversão", subtema:"Agendamento",
    formato:"Post único", funil:"FUNDO", serie:"—", mes:"Março",
    status:"Roteiro", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"Atendo em São Paulo e faço cirurgia minimamente invasiva no joelho e ombro.",
    orientacoes:"Post de conversão. Mencionar endereço, horários, convênios."
  },
  {
    id:"post-25", clienteId:"rafael",
    titulo:"Infiltração: quando ajuda e quando não resolve",
    linha:"Medicina do Estilo de Vida", subtema:"Tratamento",
    formato:"Carrossel", funil:"MEIO", serie:"Pergunte à Dra.", mes:"Abril",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"'Doutor, posso tomar mais uma infiltração?' — a resposta depende muito.",
    orientacoes:"Formato Pergunte ao Dr. Explicar indicações e limitações da infiltração."
  },
  {
    id:"post-26", clienteId:"rafael",
    titulo:"Coluna: postura no trabalho remoto",
    linha:"Medicina do Estilo de Vida", subtema:"Prevenção",
    formato:"Carrossel", funil:"TOPO", serie:"—", mes:"Banco",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"8 horas na frente do computador. Sua coluna sente — e você só vai perceber em anos.",
    orientacoes:"Dicas práticas de ergonomia. Imagens do setup correto vs. incorreto."
  },
  {
    id:"post-27", clienteId:"rafael",
    titulo:"Resultados: meus casos de artroscopia de ombro",
    linha:"Conversão", subtema:"Resultados",
    formato:"Carrossel", funil:"FUNDO", serie:"—", mes:"Banco",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"Sem antes/depois. Mas posso mostrar o que a cirurgia minimamente invasiva permite.",
    orientacoes:"ATENÇÃO: respeitar CFM. Sem antes/depois de pacientes. Mostrar técnica, não resultado estético."
  },

  /* ---- ANA (15 posts) ---- */
  {
    id:"post-40", clienteId:"ana",
    titulo:"Protetor solar: o erro que 90% das pessoas comete",
    linha:"Medicina do Estilo de Vida", subtema:"Prevenção",
    formato:"Reels", funil:"TOPO", serie:"Mito ou Verdade? 🫀", mes:"Janeiro",
    status:"Publicado", likes:4821, comentarios:612,
    data_publicacao:"2026-01-05",
    gancho:"Você passa protetor solar todo dia. Mas está aplicando errado.",
    orientacoes:"Reels rápido. Mostrar quantidade certa, reaplicação, proteção UVA e UVB."
  },
  {
    id:"post-41", clienteId:"ana",
    titulo:"Acne adulta: por que acontece depois dos 30",
    linha:"Medicina do Estilo de Vida", subtema:"Doença/Condição",
    formato:"Carrossel", funil:"MEIO", serie:"—", mes:"Janeiro",
    status:"Publicado", likes:2344, comentarios:387,
    data_publicacao:"2026-01-12",
    gancho:"Você passou a adolescência sem espinha. E agora, aos 35, está tendo acne. Por quê?",
    orientacoes:"Carrossel. Causas hormonais, estresse, cosmético errado. CTA: consulta."
  },
  {
    id:"post-42", clienteId:"ana",
    titulo:"Rotina de skincare: o que é essencial (e o que é marketing)",
    linha:"Medicina do Estilo de Vida", subtema:"Prevenção",
    formato:"Carrossel", funil:"TOPO", serie:"—", mes:"Fevereiro",
    status:"Publicado", likes:5102, comentarios:891,
    data_publicacao:"2026-02-03",
    gancho:"Todo mundo vende a 'rotina perfeita de 12 passos'. A ciência diz: você precisa de 3.",
    orientacoes:"Carrossel com os 3 essenciais (limpeza, hidratação, proteção). Simplificar."
  },
  {
    id:"post-43", clienteId:"ana",
    titulo:"Melasma: mitos e verdades",
    linha:"Medicina do Estilo de Vida", subtema:"Doença/Condição",
    formato:"Carrossel", funil:"MEIO", serie:"Mito ou Verdade? 🫀", mes:"Fevereiro",
    status:"Publicado", likes:3187, comentarios:429,
    data_publicacao:"2026-02-17",
    gancho:"'Melasma tem cura.' Mito ou verdade? (E a resposta vai te surpreender.)",
    orientacoes:"Formato Mito ou Verdade. 5 mitos comuns. Resposta científica para cada um."
  },
  {
    id:"post-44", clienteId:"ana",
    titulo:"Câncer de pele: o que observar na própria pele",
    linha:"Causa & Conscientização", subtema:"Prevenção",
    formato:"Carrossel", funil:"TOPO", serie:"—", mes:"Março",
    status:"Publicado", likes:2891, comentarios:234,
    data_publicacao:"2026-03-10",
    gancho:"Você tem 5 minutos? É o tempo que leva para fazer um autoexame da pele.",
    orientacoes:"ABCDE do melanoma. Imagens ilustrativas (não de pacientes). CTA: agendar mapeamento."
  },
  {
    id:"post-45", clienteId:"ana",
    titulo:"Botox preventivo: com que idade começar?",
    linha:"Conversão", subtema:"Procedimento",
    formato:"Reels", funil:"FUNDO", serie:"Pergunte à Dra.", mes:"Março",
    status:"Publicado", likes:7234, comentarios:1102,
    data_publicacao:"2026-03-24",
    gancho:"'Dra., tenho 28 anos. Já preciso de botox?' — Respondendo de uma vez por todas.",
    orientacoes:"Formato Pergunte à Dra. Resposta direta, sem alarmismo, sem vender excessivamente."
  },
  {
    id:"post-46", clienteId:"ana",
    titulo:"Pele oleosa no verão: o que realmente funciona",
    linha:"Medicina do Estilo de Vida", subtema:"Cuidado",
    formato:"Reels", funil:"TOPO", serie:"—", mes:"Abril",
    status:"Editado", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"Você lava o rosto 3 vezes ao dia para controlar a oleosidade. Está piorando.",
    orientacoes:"Explicar barreira cutânea. Produto certo: tônico, hidratante oil-free."
  },
  {
    id:"post-47", clienteId:"ana",
    titulo:"Consultório aberto: tire suas dúvidas de skincare",
    linha:"Conversão", subtema:"Q&A",
    formato:"Post único", funil:"FUNDO", serie:"Pergunte à Dra.", mes:"Abril",
    status:"Roteiro", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"Manda sua dúvida de skincare nos comentários. Respondo as mais votadas.",
    orientacoes:"Post de engajamento. Usar formato de pergunta aberta. Responder nos comentários."
  },
  {
    id:"post-48", clienteId:"ana",
    titulo:"Ácido hialurônico x colágeno: qual comprar?",
    linha:"Medicina do Estilo de Vida", subtema:"Educacional",
    formato:"Carrossel", funil:"MEIO", serie:"—", mes:"Maio",
    status:"Roteiro", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"A prateleira da farmácia está cheia. Mas qual deles realmente funciona na pele?",
    orientacoes:"Carrossel comparativo. Evidências científicas para cada ingrediente."
  },
  {
    id:"post-49", clienteId:"ana",
    titulo:"Peeling químico: para que serve e para quem é indicado",
    linha:"Conversão", subtema:"Procedimento",
    formato:"Carrossel", funil:"FUNDO", serie:"—", mes:"Maio",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"Já fez peeling e ficou com a pele descamando por uma semana? Isso era esperado.",
    orientacoes:"Explicar tipos de peeling, indicações, cuidados pós. ATENÇÃO: sem antes/depois de pacientes."
  },
  {
    id:"post-50", clienteId:"ana",
    titulo:"Vitamina C tópica: como escolher a certa",
    linha:"Medicina do Estilo de Vida", subtema:"Educacional",
    formato:"Reels", funil:"TOPO", serie:"—", mes:"Banco",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"Você gastou R$ 200 num sérum de vitamina C que não funciona. Veja por quê.",
    orientacoes:"Explicar ácido ascórbico vs. derivados. Concentração ideal. Como armazenar."
  },
  {
    id:"post-51", clienteId:"ana",
    titulo:"Dermatite atópica em adultos — o que mudou no tratamento",
    linha:"Medicina do Estilo de Vida", subtema:"Doença/Condição",
    formato:"Carrossel", funil:"MEIO", serie:"—", mes:"Banco",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"Você acha que dermatite atópica é coisa de bebê. Ela discorda.",
    orientacoes:"Novos tratamentos biológicos. Linguagem acessível. CTA: consulta especializada."
  },
  {
    id:"post-52", clienteId:"ana",
    titulo:"Manchas na pele: quando é sinal de alarme",
    linha:"Causa & Conscientização", subtema:"Prevenção",
    formato:"Post único", funil:"TOPO", serie:"—", mes:"Banco",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"Nem toda mancha é câncer. Mas toda mancha merece atenção.",
    orientacoes:"Post de conscientização. Sinais de alerta. CTA: mapeamento corporal."
  },
  {
    id:"post-53", clienteId:"ana",
    titulo:"Por que você precisa de uma dermatologista — não só de uma esteticista",
    linha:"Conversão", subtema:"Diferencial",
    formato:"Carrossel", funil:"FUNDO", serie:"—", mes:"Banco",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"A esteticista cuida da aparência. A dermatologista cuida da saúde da sua pele.",
    orientacoes:"Sem desmerecer estéticas. Diferenciar diagnóstico médico de procedimento estético."
  },
  {
    id:"post-54", clienteId:"ana",
    titulo:"Procedimentos estéticos: o que combinar e o que não combinar",
    linha:"Conversão", subtema:"Procedimento",
    formato:"Carrossel", funil:"FUNDO", serie:"—", mes:"Banco",
    status:"Ideia", likes:0, comentarios:0,
    data_publicacao:null,
    gancho:"Fez laser semana passada e quer fazer peeling agora? Pode ser um erro.",
    orientacoes:"Protocolo de combinação de procedimentos. Tom educativo, não alarmista."
  }
];

/* -----------------------------------------------
   OBJETIVOS MÊS A MÊS
----------------------------------------------- */
const OBJETIVOS_MES = {
  paola: {
    Abril: {
      objetivo: "Lançamento da nova fase em SP + Dia Mundial da Saúde (7/abr)",
      orcamento_anuncios: "R$ 250–350",
      tipo_anuncio: "Reconhecimento de Marca",
      datas_importantes: ["7/abr — Dia Mundial da Saúde"],
      funil_meta: { topo: 50, meio: 30, fundo: 20 }
    },
    Maio: {
      objetivo: "Saúde da mulher + Dia das Mães (10/mai)",
      orcamento_anuncios: "R$ 100",
      tipo_anuncio: "Engajamento",
      datas_importantes: ["10/mai — Dia das Mães"],
      funil_meta: { topo: 50, meio: 30, fundo: 20 }
    },
    Junho: {
      objetivo: "Exercício físico e cardiologia — posicionamento como médica do esporte cardíaco",
      orcamento_anuncios: "R$ 150–200",
      tipo_anuncio: "Mensagens/WhatsApp",
      datas_importantes: [],
      funil_meta: { topo: 50, meio: 25, fundo: 25 }
    },
    Julho: {
      objetivo: "Posicionamento profissional em IC avançada e transplante",
      orcamento_anuncios: "R$ 100",
      tipo_anuncio: "Engajamento",
      datas_importantes: [],
      funil_meta: { topo: 50, meio: 30, fundo: 20 }
    },
    Agosto: {
      objetivo: "Fatores de risco cardiovascular + aquecimento para Setembro",
      orcamento_anuncios: "R$ 100–150",
      tipo_anuncio: "Reconhecimento de Marca",
      datas_importantes: [],
      funil_meta: { topo: 60, meio: 25, fundo: 15 }
    },
    Setembro: {
      objetivo: "Campanha: Mês do Coração — máximo alcance e engajamento",
      orcamento_anuncios: "R$ 400–600",
      tipo_anuncio: "Reconhecimento de Marca + Causa",
      datas_importantes: ["27/set — Dia Nacional da Doação de Órgãos", "29/set — Dia Mundial do Coração"],
      funil_meta: { topo: 60, meio: 30, fundo: 10 }
    },
    Outubro: {
      objetivo: "Reconversão pós-campanha — trazer seguidor novo para consulta",
      orcamento_anuncios: "R$ 150–200",
      tipo_anuncio: "Mensagens/WhatsApp",
      datas_importantes: [],
      funil_meta: { topo: 40, meio: 30, fundo: 30 }
    },
    Novembro: {
      objetivo: "Prevenção e saúde preventiva — campanha de checkup",
      orcamento_anuncios: "R$ 150–200",
      tipo_anuncio: "Mensagens/WhatsApp",
      datas_importantes: [],
      funil_meta: { topo: 40, meio: 30, fundo: 30 }
    },
    Dezembro: {
      objetivo: "Fechamento do ano + cuidados nas festas + agendamento para 2027",
      orcamento_anuncios: "R$ 150–200",
      tipo_anuncio: "Mensagens/WhatsApp",
      datas_importantes: ["31/dez — Réveillon"],
      funil_meta: { topo: 30, meio: 30, fundo: 40 }
    }
  },
  rafael: {
    Janeiro: {
      objetivo: "Início de ano — lesões de quem retomou atividade física",
      orcamento_anuncios: "R$ 100",
      tipo_anuncio: "Reconhecimento de Marca",
      datas_importantes: [],
      funil_meta: { topo: 60, meio: 25, fundo: 15 }
    },
    Fevereiro: {
      objetivo: "Esporte e prevenção de lesões",
      orcamento_anuncios: "R$ 80",
      tipo_anuncio: "Engajamento",
      datas_importantes: [],
      funil_meta: { topo: 60, meio: 25, fundo: 15 }
    },
    Março: {
      objetivo: "Conversão — primeira consulta e cirurgia minimamente invasiva",
      orcamento_anuncios: "R$ 150",
      tipo_anuncio: "Mensagens",
      datas_importantes: [],
      funil_meta: { topo: 40, meio: 30, fundo: 30 }
    },
    Abril: {
      objetivo: "Procedimentos e tratamentos conservadores",
      orcamento_anuncios: "R$ 100",
      tipo_anuncio: "Engajamento",
      datas_importantes: [],
      funil_meta: { topo: 50, meio: 30, fundo: 20 }
    }
  },
  ana: {
    Janeiro: {
      objetivo: "Proteção solar e verão — máximo alcance",
      orcamento_anuncios: "R$ 200",
      tipo_anuncio: "Reconhecimento de Marca",
      datas_importantes: [],
      funil_meta: { topo: 70, meio: 20, fundo: 10 }
    },
    Fevereiro: {
      objetivo: "Educação sobre skincare — viralizar",
      orcamento_anuncios: "R$ 150",
      tipo_anuncio: "Engajamento",
      datas_importantes: [],
      funil_meta: { topo: 60, meio: 30, fundo: 10 }
    },
    Março: {
      objetivo: "Conversão + conscientização sobre câncer de pele",
      orcamento_anuncios: "R$ 200",
      tipo_anuncio: "Mensagens",
      datas_importantes: [],
      funil_meta: { topo: 40, meio: 30, fundo: 30 }
    },
    Abril: {
      objetivo: "Engajamento e Q&A — criar comunidade",
      orcamento_anuncios: "R$ 100",
      tipo_anuncio: "Engajamento",
      datas_importantes: [],
      funil_meta: { topo: 40, meio: 40, fundo: 20 }
    },
    Maio: {
      objetivo: "Procedimentos estéticos + educação sobre ingredientes",
      orcamento_anuncios: "R$ 200",
      tipo_anuncio: "Mensagens",
      datas_importantes: ["12/mai — Dia das Mães"],
      funil_meta: { topo: 30, meio: 30, fundo: 40 }
    }
  }
};

/* -----------------------------------------------
   ARRAYS EM MEMÓRIA
   Populados pelo Supabase ao carregar cada página.
   Não usar diretamente — usar db.fetchClientes()
   e db.fetchPosts() no DOMContentLoaded de cada página.
----------------------------------------------- */
// CLIENTES e POSTS já foram declarados acima como arrays vazios []
// Os dados fictícios foram removidos — o banco é a fonte da verdade.
