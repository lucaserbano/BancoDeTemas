"""
Gera banco_temas.html — dashboard interativo com todos os temas editoriais.
• Filtros múltiplos simultâneos por qualquer campo
• Busca global em tempo real
• Linhas expansíveis com texto completo
• Edição inline: dropdowns para campos categóricos, textarea para texto
• Persistência via localStorage
• Botão "Exportar HTML" para salvar versão editada em disco
"""

import json
import os

OUT = os.path.join(os.path.dirname(__file__), "banco_temas.html")

# ══════════════════════════════════════════════════════════════════════════════
# DADOS — (num, subtema, titulo, formato, funil, objetivo, gancho, orientacoes, serie, mes)
# ══════════════════════════════════════════════════════════════════════════════

MEV = [
    (1,"Exercício Físico","Exercício físico como prescrição médica","Reels","TOPO",
     "Posicionar exercício como remédio cardiovascular comprovado — não como sugestão de estilo de vida",
     "Exercício não é sugestão de estilo de vida. É prescrição médica. E eu vou te explicar por quê.",
     "Reels ≤60s. Abertura com afirmação provocativa. Dado: pacientes que se exercitam têm X% menos risco de morte cardiovascular. Linguagem de amiga médica, sem jargão. CTA fundo de funil: 'Agende sua avaliação para receber a sua prescrição.'",
     "—","Janeiro"),
    (2,"Exercício Físico","Frequência cardíaca ideal para treinar","Carrossel","MEIO",
     "Ensinar pacientes a monitorar a intensidade do exercício com segurança e sem medo",
     "Você está se exercitando forte demais — ou fraco demais. Como saber qual é o seu caso?",
     "Carrossel 6 slides. S1: pergunta-gancho. S2: FC máxima em linguagem leiga ('220 menos sua idade'). S3–4: zonas de treino com exemplos ('respiração ofegante = zona 3'). S5: sinais de alerta. S6: CTA 'Salva esse post antes do próximo treino.'",
     "—","Junho"),
    (3,"Exercício Físico","VO2max: o número que prevê sua longevidade","Reels","MEIO",
     "Apresentar VO2max como marcador de saúde cardiovascular acessível e melhorável",
     "Tem um número que prevê quanto tempo você vai viver. Seu cardiologista já te perguntou sobre ele?",
     "Reels ≤60s. Abertura com dado surpresa. Explicar VO2max como 'capacidade do coração de entregar oxigênio ao corpo'. Citar estudo de mortalidade. Boa notícia: melhora com treino regular. CTA: 'Deixa nos comentários se você conhecia esse número.'",
     "—","Junho"),
    (4,"Exercício Físico","Cardio vs musculação: qual é melhor para o coração?","Carrossel","TOPO",
     "Desmistificar que apenas aeróbico protege o coração e ampliar a percepção de exercício saudável",
     "Você vai à academia mas só faz cardio? Seu coração precisa mais do que isso.",
     "Carrossel 6 slides. S1: gancho. S2: benefícios do aeróbico. S3: benefícios surpreendentes da musculação (reduz PA, melhora insulina). S4: combinação ideal. S5: cuidados para quem tem doença cardíaca. S6: CTA 'Compartilha com quem só faz uma coisa.'",
     "—","Maio"),
    (5,"Exercício Físico","Quanto exercício por semana protege o coração?","Post único","TOPO",
     "Dar uma meta simples e acionável para o público sedentário começar a se mover",
     "30 minutos por dia, 5 vezes por semana. É tudo que o seu coração pede.",
     "Post único com infográfico limpo: pictograma 5 dias × 30 min. Legenda: 150 min semanais em pequenas metas ('pode ser 3x de 10 min'). CTA: 'Compartilha com quem precisa começar hoje.'",
     "—","Janeiro"),
    (6,"Exercício Físico","Posso fazer exercício se tenho pressão alta?","Reels","MEIO",
     "Quebrar o medo de que hipertensos não podem se exercitar — crença que piora o quadro",
     "Dra., tenho pressão alta. Posso malhar? Essa dúvida pode estar te impedindo de proteger o coração.",
     "Reels ≤60s. Voz do paciente na abertura. Resposta direta: sim, com acompanhamento. Exercício REDUZ a pressão a longo prazo. Quando NÃO fazer. CTA: 'Agende sua avaliação — prescrição individualizada.'",
     "Pergunte à Dra. Paôla 🩺","Março"),
    (7,"Exercício Físico","Exercício e insuficiência cardíaca: é seguro?","Reels","MEIO",
     "Mostrar que pacientes com IC podem e devem se exercitar — com supervisão",
     "Meu paciente me disse: 'Prefiro não arriscar.' Mas parar de se mover com insuficiência cardíaca pode piorar tudo.",
     "Reels ≤60s. Crença errada do paciente na abertura. Virada: reabilitação cardíaca reduz hospitalização. Dado de impacto. Quem indica e como funciona a prescrição segura. CTA: 'Encaminha pra quem você conhece com IC.'",
     "—","Outubro"),
    (8,"Exercício Físico","Caminhar conta como exercício para o coração?","Post único","TOPO",
     "Incentivar o público sedentário a começar com algo acessível — remover barreiras de entrada",
     "Você não precisa de academia. Nem de tênis caro. Nem de tempo sobrando. Só precisa começar.",
     "Post único com visual motivacional. Caminhada de 30 min reduz risco de infarto em X%. Meta: 'comece com 15 minutos hoje'. Tom acolhedor. CTA: 'Salva esse post pra lembrar amanhã de manhã.'",
     "—","Abril"),
    (9,"Nutrição & Dieta","Dieta DASH: a mais recomendada por cardiologistas","Carrossel","TOPO",
     "Apresentar a dieta DASH como estratégia comprovada de controle pressórico em linguagem acessível",
     "Essa dieta reduz a pressão arterial em semanas. E a maioria das pessoas nunca ouviu falar dela.",
     "Carrossel 7 slides. S1: dado de impacto sobre PA. S2: o que é a DASH em 1 frase. S3–6: componentes práticos (frutas, vegetais, laticínios magros, redução de sal) com exemplos. S7: CTA 'Salva e começa essa semana.'",
     "—","Agosto"),
    (10,"Nutrição & Dieta","Alimentos que inflamam o coração (e os substitutos)","Carrossel","TOPO",
     "Mostrar quais alimentos aumentam inflamação cardiovascular e dar opções concretas de troca",
     "Você come sem saber que está inflamando o seu coração. Vou te mostrar o que trocar.",
     "Carrossel estilo 'vilão vs herói': cada slide = 1 alimento problemático + 1 substituto com foto. Tom prático, sem julgamento. CTA: 'Qual troca você consegue fazer essa semana? Comenta aqui.'",
     "—","Agosto"),
    (11,"Nutrição & Dieta","Gordura faz mal ao coração? Mito ou verdade","Reels","TOPO",
     "Desmistificar a visão de que toda gordura é ruim — diferenciar saturada de insaturada",
     "Mito ou Verdade: gordura faz mal ao coração. Você vai se surpreender com a resposta.",
     "Reels ≤60s, formato Mito ou Verdade. 'Verdade — mas só metade da história.' Saturada (vilã) vs insaturada (aliada): manteiga vs azeite, embutido vs abacate. CTA: 'Compartilha com quem ainda tem medo de gordura.'",
     "Mito ou Verdade? 🫀","Março"),
    (12,"Nutrição & Dieta","Sal e pressão alta: quanto é seguro por dia?","Post único","TOPO",
     "Dar referência numérica clara sobre sódio e gerar consciência sobre consumo excessivo",
     "Você provavelmente está consumindo o dobro do sal recomendado — e não sabe.",
     "Post único com infográfico: colher de sal + 5g/dia (OMS). 1 dica prática para reduzir sem sofrimento. CTA: 'Salva e mede o seu sal hoje.'",
     "—","Março"),
    (13,"Nutrição & Dieta","Suplementos com evidência real para o coração","Carrossel","MEIO",
     "Orientar sobre suplementos com evidência científica e desmistificar modas sem base",
     "Ômega-3, coenzima Q10, vitamina D... Quais realmente funcionam? A resposta não é simples.",
     "Carrossel 6 slides. S1: lista de suplementos populares. S2–5: veredito por suplemento ('evidência forte / fraca / sem evidência') em linguagem leiga. S6: 'nenhum substitui medicamento prescrito' + CTA.",
     "Mito ou Verdade? 🫀","Outubro"),
    (14,"Nutrição & Dieta","O que comer antes e depois do treino para o coração","Carrossel","TOPO",
     "Cruzar nutrição e exercício para engajar público ativo e mostrar cuidado integrado",
     "Você treina mas não sabe o que comer? Seu coração sente a diferença.",
     "Carrossel 5 slides. S1: gancho. S2: antes (carboidrato leve, hidratação). S3: depois (proteína + hidratação). S4: o que EVITAR (cafeína em excesso, jejum). S5: CTA 'Salva e leva pro próximo treino.'",
     "—","Junho"),
    (15,"Nutrição & Dieta","Álcool e coração: existe dose segura?","Reels","TOPO",
     "Atualizar o público sobre as evidências mais recentes que revisaram o 'vinho faz bem'",
     "Dra., uma taça de vinho por dia faz bem para o coração? A ciência mudou de ideia — e eu preciso te contar.",
     "Reels ≤60s. Tom: 'eu sei que você não quer ouvir isso'. Citar revisão das diretrizes recentes. Sem julgamento. CTA: 'Compartilha com quem sempre usou essa justificativa.'",
     "Mito ou Verdade? 🫀","Dezembro"),
    (16,"Fatores de Risco","Hipertensão: a doença que não avisa","Reels","TOPO",
     "Criar consciência sobre a prevalência da hipertensão silenciosa e motivar check-up",
     "Pressão alta não dói. Não avisa. E quando o coração finalmente sente — já passou tempo demais.",
     "Reels ≤60s. Abertura emocional. 1 em 3 brasileiros tem hipertensão sem saber. 'Como descobrir' → 'o que fazer'. CTA: 'Você sabe sua pressão hoje? Se não, agenda uma consulta.'",
     "—","Janeiro"),
    (17,"Fatores de Risco","Diabetes tipo 2 e o risco duplo para o coração","Carrossel","MEIO",
     "Alertar diabéticos e pré-diabéticos sobre o risco cardiovascular aumentado",
     "Se você tem diabetes, o risco para o seu coração já é o dobro. Você está cuidando dos dois?",
     "Carrossel 6 slides. S1: dado de impacto. S2: por que diabetes danifica os vasos ('açúcar desgasta as paredes'). S3: exames para monitorar os dois. S4: metas de controle. S5: papel do cardiologista. S6: CTA.",
     "—","Março"),
    (18,"Fatores de Risco","Colesterol alto: remédio ou só dieta?","Reels","MEIO",
     "Orientar sobre quando a estatina é necessária e desmistificar o medo do medicamento",
     "Dra., meu colesterol tá alto. Preciso mesmo tomar remédio? Essa dúvida chega toda semana no meu consultório.",
     "Reels ≤60s. Voz do paciente. Depende do risco global, não só do número. 'Risco cardiovascular' em 1 frase. Quando só dieta basta vs quando remédio é necessário. CTA: 'Deixa nos comentários o que você já ouviu sobre estatina.'",
     "Pergunte à Dra. Paôla 🩺","Outubro"),
    (19,"Fatores de Risco","Tabagismo: o que acontece com o coração a cada cigarro","Carrossel","TOPO",
     "Mostrar o impacto imediato e progressivo do cigarro no sistema cardiovascular",
     "Você sabe o que acontece com o seu coração nos 20 minutos depois que você acende um cigarro?",
     "Carrossel cronológico. S1: gancho. S2: '2 min — FC e PA sobem'. S3: '20 min — vasos ainda contraídos'. S4: '1 ano sem fumar — risco de infarto cai à metade'. S5: onde buscar ajuda. S6: CTA.",
     "—","Novembro"),
    (20,"Fatores de Risco","Gordura abdominal e risco cardiovascular","Post único","TOPO",
     "Associar gordura visceral ao risco cardíaco sem julgamento estético — foco em saúde",
     "Não é sobre estética. É sobre o coração.",
     "Post único visual limpo. Circunferência de risco (homens >94cm, mulheres >80cm) + por que essa gordura é diferente. Tom acolhedor, zero julgamento. CTA: 'Salva e mede hoje em casa.'",
     "—","Abril"),
    (21,"Fatores de Risco","Sedentarismo: o risco invisível do dia a dia","Reels","TOPO",
     "Criar urgência sobre o sedentarismo para motivar pequenas mudanças de comportamento",
     "Ficar sentado por 8 horas por dia é tão perigoso para o coração quanto fumar. Você sabia disso?",
     "Reels ≤60s. Dado de impacto na abertura. Mecanismo: inflamação crônica, PA elevada, resistência à insulina. Dicas práticas sem academia. CTA: 'Levanta e faz 5 minutos de caminhada agora.'",
     "—","Janeiro"),
    (22,"Fatores de Risco","Histórico familiar de doença cardíaca: o que fazer?","Carrossel","TOPO",
     "Sensibilizar quem tem parentes com doença cardíaca a fazer rastreamento precoce",
     "Seu pai ou mãe teve infarto? Isso importa — mas não é destino. Vou te explicar.",
     "Carrossel 5 slides. S1: gancho empoderador. S2: o que herança genética significa de verdade. S3: fatores que você PODE controlar. S4: quais exames pedir e quando. S5: CTA.",
     "—","Fevereiro"),
    (23,"Fatores de Risco","Estresse crônico como fator de risco cardiovascular","Reels","TOPO",
     "Conectar saúde mental à saúde cardiovascular — ampliar a percepção de prevenção",
     "O estresse que você normaliza pode estar matando o seu coração. E isso não é figura de linguagem.",
     "Reels ≤60s. Abertura emocional forte. Mecanismo: cortisol → inflamação → artérias. Conexão com sono e IC. Tom: 'você não está exagerando, seu corpo sente de verdade'. CTA: 'Compartilha com quem precisa ouvir isso.'",
     "—","Fevereiro"),
    (24,"Sono & Estresse","Apneia do sono e o coração: a conexão que poucos conhecem","Reels","MEIO",
     "Alertar sobre apneia obstrutiva como fator de risco cardiovascular subestimado",
     "Você ronca? Acorda cansado mesmo depois de dormir? Isso pode estar sobrecarregando o seu coração.",
     "Reels ≤60s. Sintomas que o paciente reconhece. Mecanismo: falta de oxigênio à noite → PA sobe → coração sofre. Citar polissonografia. CTA: 'Pergunta pro seu parceiro se você ronca e agenda uma avaliação.'",
     "—","Agosto"),
    (25,"Sono & Estresse","Quantas horas de sono protegem o coração?","Post único","TOPO",
     "Estabelecer sono como pilar da saúde cardiovascular — simples e direto",
     "7 a 9 horas. Não é luxo — é cardioprevenção.",
     "Post único com tipografia limpa e impactante. Sono <6h e risco de infarto. Tom firme mas acolhedor. CTA: 'Compartilha com quem dorme pouco achando que tá tudo bem.'",
     "—","Agosto"),
    (26,"Sono & Estresse","Síndrome de Takotsubo: o coração pode se partir de emoção?","Reels","MEIO",
     "Explicar o Takotsubo de forma emocional e educativa — alta compartilhabilidade",
     "Dra., é verdade que existe síndrome do coração partido? Uma paciente me fez essa pergunta — e a resposta é sim.",
     "Reels ≤60s. Pergunta real da paciente na abertura. Takotsubo em linguagem leiga: 'estresse emocional intenso pode paralisar parte do coração temporariamente'. Quem está em risco. Como tratar. CTA: 'Compartilha com quem está passando por um momento difícil.'",
     "Pergunte à Dra. Paôla 🩺","Fevereiro"),
    (27,"Sono & Estresse","Estresse crônico deixa marcas reais no coração","Carrossel","MEIO",
     "Aprofundar a relação entre estresse, inflamação e doença cardiovascular",
     "O estresse não é 'coisa da cabeça'. Ele deixa marcas reais e visíveis no seu coração.",
     "Carrossel 6 slides. S1: gancho debunking. S2: mecanismo (cortisol → inflamação → aterosclerose). S3: estresse agudo vs crônico. S4–5: estratégias com evidência. S6: CTA.",
     "—","Maio"),
    (28,"Exames & Diagnóstico","ECG: o que essa folha de papel revela sobre você","Carrossel","MEIO",
     "Desmistificar o ECG e mostrar seu valor diagnóstico de forma visual e acessível",
     "Esse exame é só uma folha de papel. Mas ela conta a história do seu coração — e eu vou te ensinar a ler.",
     "Carrossel 7 slides. S1: gancho. S2: foto real de ECG com destaque nas ondas. S3–5: o que cada parte revela em linguagem leiga. S6: quando o médico pede. S7: CTA 'Salva — na próxima consulta você vai entender seu próprio ECG.'",
     "—","Agosto"),
    (29,"Exames & Diagnóstico","Ecocardiograma: por que o médico pediu esse exame?","Reels","MEIO",
     "Explicar o ecocardiograma de forma acessível para pacientes que receberam a solicitação",
     "O cardiologista pediu um ecocardiograma. O que isso significa? Primeiro: não precisa se assustar.",
     "Reels ≤60s. Tranquilizar na abertura. 'É um ultrassom do coração, não dói, não irradia'. O que avalia (estrutura, função, válvulas). Quando é indicado. CTA: 'Deixa nos comentários se você já fez um.'",
     "Pergunte à Dra. Paôla 🩺","Setembro"),
    (30,"Exames & Diagnóstico","MAPA: quando a pressão no consultório engana","Post único","TOPO",
     "Explicar o MAPA e o fenômeno da hipertensão do jaleco branco",
     "Você sabia que a sua pressão pode ser diferente em casa e no consultório? Isso tem nome — e tem solução.",
     "Post único com foto do aparelho + legenda. 'Hipertensão do jaleco branco' em 2 frases. Quando o MAPA é indicado. CTA: 'Pergunta pro seu cardiologista se você precisa desse exame.'",
     "—","Abril"),
    (31,"Exames & Diagnóstico","Teste ergométrico: por que o médico pediu a esteira?","Reels","MEIO",
     "Orientar sobre o que o teste ergométrico avalia e quando é indicado",
     "O cardiologista pediu uma esteira. O que esse exame realmente mede sobre o seu coração?",
     "Reels ≤60s. Dúvida do paciente na abertura. Capacidade funcional, isquemia e arritmia durante esforço. Para quem é indicado. Como é feito. CTA: 'Já fez esse exame? Conta nos comentários como foi.'",
     "Pergunte à Dra. Paôla 🩺","Novembro"),
    (32,"Exames & Diagnóstico","Checkup cardiovascular: quem precisa e com qual frequência?","Carrossel","TOPO",
     "Gerar demanda por consulta de rastreamento — mostrar que prevenção é para todos",
     "Quando foi a última vez que você checou a saúde do seu coração? Se você precisou pensar — já passou da hora.",
     "Carrossel 5 slides. S1: dado de mortalidade. S2: quem deve fazer (grupos de risco + assintomáticos >40). S3: frequência por faixa etária. S4: o que é avaliado. S5: CTA direto 'Agende sua avaliação — Einstein, São Luiz Itaim, Dante Pazzanese.'",
     "—","Janeiro"),
    (33,"Exames & Diagnóstico","Exame de sangue e coração: o que pedir ao médico","Carrossel","TOPO",
     "Empoderar o paciente a saber quais exames solicitar para rastreamento cardiovascular",
     "Você vai ao médico mas não sabe o que pedir pra proteger o seu coração. Aqui está o checklist.",
     "Carrossel tipo checklist. S1: gancho empoderador. S2–5: exames essenciais (colesterol fracionado, glicemia, PCR-us, hemograma) com o que cada um revela. S6: CTA 'Salva antes da sua próxima consulta.'",
     "—","Abril"),
    (34,"Exames & Diagnóstico","Holter 24h: quando o coração precisa ser monitorado","Post único","MEIO",
     "Explicar o Holter de forma simples para pacientes que receberão a solicitação",
     "Sentiu o coração disparar ou pular um batimento? Esse exame pode finalmente dar uma resposta.",
     "Post único com foto discreta do aparelho. O que o Holter registra. Quando é indicado (palpitações, tontura, síncope). Tom tranquilizador. CTA: 'Já usou um Holter? Conta nos comentários.'",
     "Pergunte à Dra. Paôla 🩺","Julho"),
    (35,"Doenças Cardiovasculares","Insuficiência cardíaca: os sintomas que você não pode ignorar","Reels","MEIO",
     "Alertar para sintomas de IC e motivar busca por diagnóstico precoce",
     "Cansaço ao subir uma escada. Falta de ar ao deitar. Pés inchados. Esses sinais têm algo em comum — e falam sobre o seu coração.",
     "Reels ≤60s. Sintomas concretos que o paciente reconhece. 'Muita gente acha que é cansaço de trabalho ou da idade'. Revelar: podem ser sinais de IC. CTA: 'Encaminha pra quem tem esses sintomas e ainda não foi ao médico.'",
     "—","Outubro"),
    (36,"Doenças Cardiovasculares","Arritmia: quando o coração bate diferente","Reels","MEIO",
     "Tranquilizar e orientar quem já sentiu arritmia sobre quando buscar avaliação urgente",
     "Senti o coração bater diferente. Preciso me preocupar? Depende — e eu vou te explicar a diferença.",
     "Reels ≤60s. Medo do paciente na abertura. Benignas (extrassístoles) vs sinais de alerta (taquicardia sustentada, síncope). Quando ir ao PS vs consulta eletiva. CTA: 'Salva — pode ser útil num momento de susto.'",
     "Pergunte à Dra. Paôla 🩺","Maio"),
    (37,"Doenças Cardiovasculares","Miocardiopatia: quando o músculo do coração adoece","Reels","MEIO",
     "Explicar o conceito de miocardiopatia e seus tipos para pacientes com diagnóstico ou risco",
     "Você sabia que o próprio músculo do coração pode adoecer — independente dos vasos e das válvulas?",
     "Reels ≤60s. Dado surpresa na abertura. Tipos em linguagem leiga: 'dilatada (grande e fraco), hipertrófica (espessado), restritiva (rígido)'. Conectar com IC avançada. CTA: 'Agende avaliação se tem histórico familiar ou sintomas.'",
     "—","Outubro"),
    (38,"Doenças Cardiovasculares","Aterosclerose: a placa que se forma em silêncio","Carrossel","TOPO",
     "Visualizar o processo de aterosclerose para aumentar percepção de risco e motivar prevenção",
     "A placa de gordura no seu vaso não surge do dia para a noite. É um processo de anos — que começa antes dos 30.",
     "Carrossel visual com ilustração do processo. S1: gancho temporal. S2: artéria saudável. S3: formação da placa. S4: estreitamento e risco de infarto. S5: o que freia esse processo. S6: CTA.",
     "—","Julho"),
    (39,"Doenças Cardiovasculares","Infarto: os sinais que muita gente não reconhece","Reels","TOPO",
     "Ampliar capacidade do público de reconhecer sintomas atípicos de infarto e agir rápido",
     "Infarto não começa sempre com dor no peito. Esses outros sinais salvam vidas — e muita gente não conhece.",
     "Reels de alto impacto. Sintomas atípicos: dor no braço/mandíbula/costas, náusea, suor frio. Sintomas em mulheres são diferentes. 'Ligue 192 imediatamente'. CTA: 'Compartilha. Pode salvar uma vida.'",
     "—","Setembro"),
    (40,"Doenças Cardiovasculares","Prevenção primária vs secundária: você sabe qual é a sua?","Post único","TOPO",
     "Explicar os dois tipos de prevenção e posicionar a Paôla como especialista em ambos",
     "Mito ou Verdade: prevenção cardiovascular é só para quem ainda não teve problema no coração.",
     "Post único formato Mito ou Verdade. Resposta: MITO. Prevenção primária (antes da doença) e secundária (após evento). CTA: 'Sabe qual é a sua? Agende sua avaliação.'",
     "Mito ou Verdade? 🫀","Abril"),
]

CONV = [
    (1,"Apresentação & Posicionamento","Apresentação: nova fase em São Paulo","Reels","FUNDO",
     "Marcar o início do perfil renovado apresentando a Paôla como especialista em IC avançada e transplante, recém estabelecida em SP, humanizando a marca sem perder autoridade médica.",
     "Eu sou cardiologista. Mas a especialidade que escolhi cuida de quem o coração já não consegue mais sozinho. Agora em São Paulo — e quero te apresentar o meu trabalho.",
     "Reels ≤60s. Abertura com posicionamento (não 'olá, me chamo'). Mostrar rosto, tom acolhedor e direto. Citar os 3 locais de atendimento. CTA: 'Me segue — toda semana tem conteúdo sobre saúde do coração.' Fundo neutro ou consultório.",
     "—","Abril"),
    (2,"Diferenciais & Especialidade","Meus diferenciais: IC avançada e transplante cardíaco","Carrossel","FUNDO",
     "Explicar de forma acessível o que é a especialidade de IC avançada e transplante, e por que ter um especialista faz diferença — gerando desejo de consulta.",
     "Nem todo cardiologista trata o mesmo. Vou te explicar o que faz um especialista em insuficiência cardíaca avançada — e por que isso pode mudar tudo no seu cuidado.",
     "Carrossel 6 slides. S1: diferenciação. S2: IC avançada em 1 frase leiga. S3: o que o especialista faz diferente. S4: perfil do paciente ideal. S5: onde atendo (Einstein, São Luiz, Dante Pazzanese). S6: CTA.",
     "—","Abril"),
    (3,"Apresentação & Posicionamento","Cuidar da saúde = o melhor presente para quem você ama","Post único","FUNDO",
     "Usar o gancho emocional do Dia das Mães para conectar cuidado com saúde e gerar CTA de agendamento sem parecer apelativo.",
     "A melhor coisa que você pode fazer pela sua família não tem embrulho. É continuar aqui.",
     "Post único com visual emocional. Legenda curta: 2-3 frases conectando saúde cardiovascular à presença para a família. CTA: 'Agende sua consulta — atendo no Einstein, São Luiz Itaim e Dante Pazzanese.' Publicar próximo ao Dia das Mães (10/mai).",
     "—","Maio"),
    (4,"Onde Atendo & Agenda","Onde te atendo em SP e como agendar sua consulta","Post único","FUNDO",
     "Remover a fricção do processo de agendamento: dar todas as informações práticas de forma clara e memorável.",
     "Você quer agendar, mas não sabe por onde começar. Deixa eu facilitar isso pra você.",
     "Post único guia prático. Visual com os 3 locais. Legenda: nome dos hospitais + como agendar em cada um. Tom acolhedor e prático. CTA: 'Salva esse post — quando precisar, estará aqui.' Fixar no perfil após publicação.",
     "—","Junho"),
    (5,"Primeira Consulta","O que esperar da sua primeira consulta comigo","Carrossel","FUNDO",
     "Reduzir a ansiedade do paciente sobre o que acontece na consulta e antecipar o valor da avaliação especializada — transformando curiosidade em decisão.",
     "Dra., o que você faz na consulta? Essa pergunta chega toda semana. Vou responder de um jeito diferente: te conto exatamente o que acontece quando você senta na minha frente.",
     "Carrossel 6 slides. S1: pergunta do paciente. S2: 'começo pela sua história'. S3: exame físico cardiovascular. S4: revisão dos exames (o que trazer). S5: construção do plano junto. S6: CTA 'Pronto para agendar? Link na bio.'",
     "Pergunte à Dra. Paôla 🩺","Julho"),
    (6,"Diferenciais & Especialidade","Por que consultar um especialista em IC avançada?","Reels","FUNDO",
     "Gerar consciência sobre a importância do acompanhamento especializado em IC — posicionar a Paôla como a profissional certa para esse público.",
     "Se você tem insuficiência cardíaca e não está sendo acompanhado por um especialista, precisa ouvir isso.",
     "Reels ≤60s. Tom direto e urgente. Dado de impacto: mortalidade de IC não tratada adequadamente. Diferenciar clínico geral vs cardiologista vs especialista em IC. O que o especialista monitora. CTA: 'Agende sua avaliação — link na bio.'",
     "—","Agosto"),
    (7,"Onde Atendo & Agenda","Dia Mundial do Coração: agende sua avaliação cardiovascular","Post único","FUNDO",
     "Aproveitar o Dia Mundial do Coração (29/set) para gerar CTA de agendamento com urgência legítima e emocional.",
     "Hoje é o Dia Mundial do Coração. E eu tenho um pedido: não deixa pra amanhã o que pode salvar a sua vida.",
     "Post único de alto impacto visual (coração, paleta vermelha). Legenda emocional: estatística + convite. CTA direto: 'Agende agora — Einstein, São Luiz Itaim, Dante Pazzanese. Link na bio.' Publicar 29/set. Considerar impulsionamento.",
     "—","Setembro"),
    (8,"Q&A & Engajamento","Q&A: respondendo suas dúvidas sobre o coração","Carrossel","FUNDO",
     "Gerar engajamento com perguntas reais dos seguidores, mostrar acessibilidade e construir confiança — convertendo seguidores em pacientes.",
     "Toda semana chegam perguntas na minha caixa. Hoje eu respondo as mais repetidas — com a mesma atenção que daria no consultório.",
     "Carrossel 6-8 slides. Cada slide = 1 pergunta real + resposta curta em linguagem leiga. Fundo escuro, pergunta em branco, resposta em destaque. Último slide: 'Manda sua pergunta nos comentários.' CTA de agendamento discreto no final.",
     "Pergunte à Dra. Paôla 🩺","Outubro"),
    (9,"Diferenciais & Especialidade","Por que me escolher como sua cardiologista","Reels","FUNDO",
     "Post de autoridade: consolidar percepção de valor antes do fechamento do ano, capturando indecisos que já seguem há meses.",
     "Existem muitos cardiologistas em São Paulo. Vou te contar o que me diferencia — não para me vender, mas para que você tome a melhor decisão para a sua saúde.",
     "Reels ≤60s. Tom seguro, sem arrogância. Formação em IC avançada e transplante, hospitais de referência, medicina do estilo de vida + alta tecnologia, atendimento humanizado. Não citar preços (vedado pelo CFM). CTA: 'Agende sua consulta.'",
     "—","Novembro"),
    (10,"Onde Atendo & Agenda","Agende seu checkup cardiovascular para 2027","Post único","FUNDO",
     "Fechar o ano com CTA de planejamento preventivo, criando urgência positiva e gerando agenda para janeiro/2027.",
     "O ano acabou. Mas o coração trabalhou 365 dias sem parar. Quando foi a última vez que você cuidou dele?",
     "Post único com visual de virada de ano (minimalista). Legenda: dado de prevenção + convite ao checkup. CTA: 'Agende agora para janeiro — Einstein, São Luiz Itaim, Dante Pazzanese. Link na bio.' Considerar impulsionamento.",
     "—","Dezembro"),
    (11,"Apresentação & Posicionamento","Minha trajetória: por que escolhi IC avançada e transplante","Reels","FUNDO",
     "Humanizar a marca médica contando a história de como chegou à subespecialidade mais complexa da cardiologia — gerar conexão e confiança com pacientes que precisam de referência.",
     "A maioria dos médicos foge da IC avançada. Eu corri em direção a ela. Deixa eu te contar por quê.",
     "Reels ≤90s. Tom pessoal e autêntico — não currículo, uma história. Contar o que levou à escolha: o primeiro contato com IC avançada, o que a especialidade representa. Encerrar com propósito. CTA: 'Me segue — estou aqui pra te mostrar que IC avançada tem tratamento.'",
     "—","Banco"),
    (12,"Diferenciais & Especialidade","IC avançada não é o fim — é o começo de um novo protocolo","Reels","FUNDO",
     "Desconstruir o medo e o estigma associados ao diagnóstico de IC avançada, posicionando o tratamento especializado como esperança real.",
     "Meu paciente chegou achando que tinha recebido uma sentença. O que eu disse a ele mudou tudo.",
     "Reels ≤60s. Narrativa de paciente (sem identificação) na abertura. Virada emocional: IC avançada hoje com o Quarteto Fantástico + possibilidade de transplante. Tom esperançoso e realista. CTA: 'Se você ou alguém próximo tem IC avançada, me manda uma mensagem.'",
     "—","Banco"),
    (13,"Primeira Consulta","Quais exames trazer na primeira consulta comigo?","Carrossel","FUNDO",
     "Reduzir a barreira de agendamento com um checklist prático — elimina a insegurança de 'não sei se estou preparado'.",
     "Antes de vir ao consultório, você precisa ler isso. Vai tornar nossa consulta muito mais completa.",
     "Carrossel 6 slides checklist. S1: gancho. S2: exames cardiovasculares (ECG, eco, MAPA, Holter). S3: exames de sangue (colesterol, glicemia, função renal, TSH). S4: laudos e relatórios anteriores. S5: lista de medicamentos. S6: CTA. Indicado para fixar no perfil.",
     "—","Banco"),
    (14,"Primeira Consulta","Como me preparar para a consulta cardiológica","Post único","FUNDO",
     "Empoderar o paciente novo, reduzindo ansiedade pré-consulta e aumentando a qualidade do encontro clínico desde o primeiro contato.",
     "Uma consulta boa começa antes de você entrar no consultório. Aqui está o que fazer.",
     "Post único guia visual rápido. 4-5 dicas: anotar sintomas com frequência/intensidade, trazer lista de medicamentos, registrar PA em casa se hipertenso, não ir em jejum sem exame, anotar perguntas com antecedência. CTA: 'Salva antes da sua próxima consulta.'",
     "—","Banco"),
    (15,"Onde Atendo & Agenda","Atendo convênio? Como acessar minha consulta","Post único","FUNDO",
     "Remover a barreira de acesso mais frequente: 'será que aceita meu plano?' — ser transparente sobre as opções e eliminar desistência por dúvida prática.",
     "A pergunta que mais recebo no DM: Dra., você atende convênio? Vou responder de uma vez por todas.",
     "Post único direto e prático. Listar planos aceitos em cada hospital (preencher com dados reais). Canal de agendamento de cada hospital. Opção de consulta particular quando aplicável. CTA: 'Me manda uma mensagem se tiver dúvida sobre seu plano.'",
     "—","Banco"),
    (16,"Onde Atendo & Agenda","Einstein, São Luiz Itaim, Dante Pazzanese: por que esses hospitais?","Carrossel","FUNDO",
     "Posicionar os hospitais como referências de excelência e reforçar que a escolha não é arbitrária — aumentar confiança e senso de segurança.",
     "Não escolhi esses hospitais por acaso. Cada um tem um papel no meu trabalho com você.",
     "Carrossel 4 slides. S1: gancho. S2: Albert Einstein — referência em IC e transplante. S3: São Luiz Itaim — excelência cardiovascular, equipe multidisciplinar. S4: Dante Pazzanese — instituto cardiológico de referência nacional. Último slide: logos/fotos + CTA.",
     "—","Banco"),
    (17,"Diferenciais & Especialidade","Acompanhamento pós-transplante: o que acontece depois?","Reels","FUNDO",
     "Mostrar o ciclo completo do cuidado pós-transplante — posicionar como expert em todo o espectro do tratamento, do diagnóstico ao pós-cirúrgico.",
     "O transplante foi. E agora? O que ninguém te conta sobre o que vem depois.",
     "Reels ≤60s. Lacuna de informação dos pacientes na abertura. Biópsia de rotina (o que é), ajuste de imunossupressores, restrições e liberdades progressivas, qualidade de vida real. Tom: realista, esperançoso e prático. CTA: 'Manda nos comentários se você é transplantado ou familiar.'",
     "—","Banco"),
    (18,"Q&A & Engajamento","Quando buscar um segundo parecer cardiológico?","Reels","FUNDO",
     "Empoderar o paciente a buscar especialização quando necessário — posicionando a Paôla como a referência ideal para segundo parecer em IC avançada.",
     "Você tem o direito de buscar um segundo parecer. E às vezes ele muda tudo.",
     "Reels ≤60s. Caso (sem identificação) em que o segundo parecer foi decisivo. Quando buscar: IC sem melhora, sintomas inexplicados, cirurgia indicada, dúvida sobre diagnóstico. Tom empoderador — sem criticar outros médicos. CTA: 'Se está em dúvida, me manda uma mensagem — posso ser seu segundo parecer.'",
     "Pergunte à Dra. Paôla 🩺","Banco"),
    (19,"Q&A & Engajamento","Perguntas que você tem direito de fazer ao seu médico","Carrossel","FUNDO",
     "Posicionar a Paôla como médica que respeita a autonomia do paciente e estimula participação ativa — diferencial de relacionamento que converte seguidores que se sentem seguros.",
     "Consulta não é monólogo. Você tem perguntas importantes a fazer — e o direito de receber respostas.",
     "Carrossel 7 slides. S1: gancho. S2-6: perguntas essenciais ('Por que esse medicamento?' / 'Quais efeitos colaterais?' / 'Quais sinais de alerta?' / 'Quando retorno?' / 'Existe outra opção?'). S7: 'Na minha consulta, você pode e deve fazer todas essas perguntas.' CTA: 'Salva e leva pra próxima consulta.'",
     "—","Banco"),
    (20,"Diferenciais & Especialidade","Clínico geral, cardiologista, especialista em IC: qual é a diferença?","Carrossel","FUNDO",
     "Educar sobre os diferentes papéis no cuidado cardiovascular, criando consciência de que o paciente com IC avançada precisa de acompanhamento especializado.",
     "Clínico geral, cardiologista, especialista em IC avançada. São três coisas diferentes — e o seu coração merece saber a diferença.",
     "Carrossel comparativo 5 slides. S1: gancho. S2: clínico geral (rastreamento, encaminhamento). S3: cardiologista geral (maioria das condições). S4: especialista em IC (Quarteto Fantástico, dispositivos, transplante). S5: quando cada um é necessário + CTA.",
     "—","Banco"),
]

# ══════════════════════════════════════════════════════════════════════════════
# CAUSA & CONSCIENTIZAÇÃO — (num, subtema, titulo, formato, funil, objetivo, gancho, orientacoes, serie, mes)
# ══════════════════════════════════════════════════════════════════════════════

CAUSA = [
    (1,"Doação de Órgãos","Doação de órgãos: mitos e verdades que podem custar uma vida","Carrossel","TOPO",
     "Desmistificar as crenças mais comuns que impedem pessoas de se declararem doadoras — cada mito eliminado pode salvar uma vida em lista de espera.",
     "\"Não vou ser doador porque os médicos vão me deixar morrer de propósito.\" Essa crença existe — e ela está custando vidas.",
     "Carrossel 8 slides estilo Mito/Verdade. S1: gancho. S2–6: 1 mito por slide ('médico não se esforça para salvar doador' / 'família decide mesmo com declaração' / 'jovens não precisam se declarar' / 'religião proíbe' / 'doador não pode ter funeral aberto'). S7: dado real: Brasil tem uma das maiores listas de espera do mundo. S8: CTA 'Declare-se doador — conte para sua família agora.'",
     "Mito ou Verdade? 🫀","Banco"),
    (2,"Transplante Cardíaco","Fila de espera pelo transplante cardíaco: como funciona?","Carrossel","TOPO",
     "Humanizar e explicar o processo da lista de espera para o público geral — gerar empatia com pacientes e familiares, e motivar a declaração de doação.",
     "Alguém está esperando por um coração agora mesmo. Talvez a vizinha da sua mãe. Talvez alguém que você conhece.",
     "Carrossel 7 slides. S1: gancho emocional. S2: quem entra na lista (critérios em linguagem leiga). S3: como a fila funciona (SING, compatibilidade, urgência). S4: tempo médio de espera. S5: o que acontece enquanto se espera. S6: dado impactante — quantos morrem na fila por ano no Brasil. S7: CTA 'Declare-se doador. Link na bio.'",
     "—","Agosto"),
    (3,"Doação de Órgãos","Morte encefálica: o que é e por que importa para a doação","Reels","TOPO",
     "Esclarecer o conceito de morte encefálica — principal barreira de compreensão para a decisão de doação — em linguagem acessível e sem sensacionalismo.",
     "Morte encefálica não é coma. Não é sono profundo. É morte. E entender isso pode mudar tudo na sua decisão de doar órgãos.",
     "Reels ≤60s. Abertura direta e respeitosa. Explicar em linguagem leiga: 'o cérebro para definitivamente — o coração só bate porque máquinas sustentam a circulação'. Diferença entre coma e morte encefálica. Protocolo rigoroso de diagnóstico. Tom: informativo, sem dramatização. CTA: 'Compartilha com quem ainda tem dúvida sobre esse tema.'",
     "—","Banco"),
    (4,"Transplante Cardíaco","Qualidade de vida pós-transplante cardíaco: dados reais","Reels","TOPO",
     "Mostrar resultados concretos e humanos do transplante — dar esperança a pacientes em lista de espera e familiares, e incentivar a doação com dados positivos.",
     "Meu paciente foi transplantado. Dois anos depois, voltou a trabalhar, treinar e viver. Isso é o que os dados não mostram — mas eu vou te contar.",
     "Reels ≤60s. Narrativa de paciente (sem identificação). Dados reais: sobrevida em 1 ano (>85%), 5 anos. O que 'qualidade de vida' significa na prática: trabalho, exercício, família. Tom esperançoso e real. CTA: 'Compartilha com quem precisa de esperança hoje.'",
     "—","Junho"),
    (5,"Transplante Cardíaco","Coração artificial: a ponte entre a vida e o transplante","Reels","TOPO",
     "Explicar dispositivos de assistência ventricular (LVAD) de forma acessível — ampliar o conhecimento sobre as opções disponíveis para pacientes com IC avançada enquanto aguardam transplante.",
     "Enquanto o coração não chega, existe uma máquina que faz o coração trabalhar por você. Deixa eu te explicar.",
     "Reels ≤60s. Abertura com a realidade da lista de espera. Explicar LVAD em linguagem leiga: 'uma bomba que ajuda o coração a circular o sangue'. Para quem é indicado. Limitações e liberdades na vida diária. Tom: realista e esperançoso. CTA: 'Salva esse post — pode ser uma informação que alguém próximo precisa.'",
     "—","Dezembro"),
    (6,"Doação de Órgãos","27 de setembro: Dia Nacional de Doação de Órgãos","Post único","TOPO",
     "Marcar a data com uma publicação de alto impacto emocional que converta seguidores em potenciais doadores declarados — aproveitando o pico de atenção do mês do coração.",
     "Hoje é o dia de falar sobre o maior presente que existe: a vida. E ela pode vir de você.",
     "Post único com visual de alto impacto (coração, cor vermelha intensa). Texto curto e emocional: 1 dado sobre lista de espera + convite à declaração. CTA: 'Declare-se doador. Conte para sua família. Salva esse post.' Publicar em 27/set. Alto potencial de compartilhamento — considerar impulsionamento.",
     "—","Setembro"),
    (7,"Conscientização Cardiovascular","Setembro é o Mês do Coração: os dados que você precisa conhecer","Reels","TOPO",
     "Abrir setembro com impacto máximo — dados de mortalidade cardiovascular no Brasil para criar urgência e preparar a audiência para a campanha do mês.",
     "Todo setembro o mundo fala sobre o coração. Mas você sabe quantas pessoas vão morrer de doença cardiovascular só esse ano no Brasil?",
     "Reels ≤60s. Abertura com dado impactante (maior causa de morte no Brasil). Humanizar com comparação ('mais do que toda a população de Florianópolis'). O que pode ser prevenido vs o que não pode. Tom: urgente sem alarmismo. CTA: 'Salva esse post e compartilha — essa informação precisa circular.'",
     "—","Setembro"),
    (8,"Doação de Órgãos","Você é doador de órgãos? (Pergunta de engajamento)","Post único","TOPO",
     "Gerar engajamento máximo com uma pergunta simples — coletar dados da audiência e iniciar conversa sobre doação de órgãos de forma leve e não invasiva.",
     "Uma pergunta simples que pode salvar muitas vidas: você é doador de órgãos?",
     "Post único visual limpo com a pergunta em destaque. Propor 3 opções nos comentários: 'Sim, já me declarei' / 'Não, tenho dúvidas' / 'Nunca pensei nisso'. Responder ativamente nos comentários. Tom: acolhedor, sem julgamento, sem pressão. Bônus de setembro — publicar na semana do 27/set.",
     "—","Setembro"),
    (9,"Doação de Órgãos","Já contou para sua família que você é doador?","Reels","TOPO",
     "Incentivar o ato mais concreto de solidificar a decisão de doação — a conversa com a família, juridicamente determinante no Brasil.",
     "Você pode se declarar doador em todos os documentos do país. Mas se a sua família não souber — pode não valer de nada.",
     "Reels ≤60s. Dado legal: no Brasil, a família tem a palavra final na doação. Por isso a conversa importa. Como iniciar essa conversa sem ser pesado — scripts simples. Tom: prático e empoderador. CTA: 'Compartilha esse vídeo para a sua família ver junto com você.'",
     "—","Banco"),
    (10,"Transplante Cardíaco","Resultados do transplante cardíaco no Brasil: o que os dados dizem","Carrossel","MEIO",
     "Apresentar dados concretos sobre os resultados do transplante no Brasil — dar substância científica para pacientes e familiares avaliarem o procedimento com base em evidências.",
     "Quanto tempo dura um coração transplantado? Os dados são melhores do que você imagina.",
     "Carrossel 6 slides. S1: dado surpresa positivo (sobrevida). S2: sobrevida em 1, 5 e 10 anos com números reais. S3: qualidade de vida relatada por pacientes. S4: evolução tecnológica que melhorou os resultados. S5: papel do centro especializado nos resultados. S6: CTA 'Tem dúvida sobre transplante? Me manda uma mensagem.'",
     "—","Outubro"),
    (11,"Transplante Cardíaco","Quem está na fila de espera pelo coração?","Carrossel","TOPO",
     "Humanizar o rosto dos pacientes em lista de espera — transformar um número abstrato em pessoas reais para aumentar a empatia e motivar a declaração de doação.",
     "São quase mil pessoas esperando por um coração no Brasil. Elas têm nome, família, sonhos. Deixa eu te apresentar o perfil delas.",
     "Carrossel 6 slides. S1: dado impactante com humanização. S2: faixa etária (adultos e crianças). S3: diagnósticos mais comuns (IC avançada, miocardiopatia dilatada). S4: quanto tempo esperam em média. S5: o que fazem enquanto esperam (LVAD, restrições). S6: CTA 'Declare-se doador — você pode ser a resposta para uma dessas histórias.'",
     "—","Banco"),
    (12,"Doação de Órgãos","Como funciona a doação de órgãos? O processo passo a passo","Reels","TOPO",
     "Desmistificar o processo técnico da doação — muitas pessoas não se declaram por desconhecimento ou medo do processo, não por objeção moral.",
     "A maioria das pessoas que não é doadora, não é porque não quer. É porque não sabe o que acontece. Deixa eu explicar.",
     "Reels ≤60s. Sequência clara: diagnóstico de morte encefálica → comunicação à família → consentimento → captação no centro cirúrgico → distribuição pelo SING. Tom: respeitoso, informativo, sem detalhes mórbidos. CTA: 'Compartilha — essa informação pode mudar a decisão de alguém.'",
     "—","Banco"),
    (13,"Conscientização Cardiovascular","Brasil no transplante cardíaco: onde estamos no mundo?","Post único","TOPO",
     "Posicionar o Brasil no contexto global de transplante cardíaco — mostrar que o gap entre oferta e demanda é um problema solucionável com mais doadores declarados.",
     "O Brasil é o 2º país do mundo em número de transplantes de órgãos. E ainda assim a fila não para de crescer.",
     "Post único com infográfico comparativo. Dado: posição do Brasil globalmente. Por que a fila não fecha: proporção doadores/população vs países líderes. Solução simples: mais declarações de doação + conversa familiar. CTA: 'Salva e compartilha — informação que transforma.'",
     "—","Banco"),
    (14,"Transplante Cardíaco","Quando a insuficiência cardíaca chega ao ponto do transplante?","Reels","MEIO",
     "Esclarecer os critérios de indicação do transplante cardíaco — orientar pacientes com IC avançada e familiares sobre quando e por que essa opção é discutida.",
     "\"Dra., meu pai tem insuficiência cardíaca. Vai precisar de transplante?\" Essa pergunta chega toda semana. A resposta não é simples — mas eu vou te explicar os critérios.",
     "Reels ≤60s. Voz do familiar preocupado na abertura. Critérios em linguagem leiga: IC avançada refratária ao tratamento máximo, FEVE muito baixa, hospitalizações frequentes, qualidade de vida gravemente comprometida. Alternativas antes do transplante. Tom: claro, sem alarmismo. CTA: 'Manda sua dúvida nos comentários.'",
     "Pergunte à Dra. Paôla 🩺","Banco"),
    (15,"Doação de Órgãos","A família disse não: o que acontece com a doação?","Reels","TOPO",
     "Explicar o papel legal e emocional da família na doação — e porque a conversa prévia é a única proteção real da vontade do doador.",
     "Você se declarou doador. Mas se a sua família disser não na hora mais difícil da vida delas — os seus órgãos não vão ser doados. É assim que funciona no Brasil.",
     "Reels ≤60s. Tom respeitoso e direto. Explicar o framework legal brasileiro. Por que a família diz não: desconhecimento, dor, urgência da decisão. Como a conversa prévia muda tudo. CTA: 'Compartilha com sua família agora — antes que esse momento chegue.'",
     "—","Banco"),
    (16,"Transplante Cardíaco","Por que o transplantado toma remédio para sempre?","Carrossel","MEIO",
     "Explicar a imunossupressão de forma acessível — eliminar o medo de pacientes e familiares sobre o uso de medicamentos a longo prazo e reforçar a importância da adesão.",
     "Depois do transplante, o remédio não para. Nunca. E tem um motivo muito importante para isso.",
     "Carrossel 6 slides. S1: gancho. S2: por que o corpo rejeita o coração ('exército de defesa atacando o novo órgão'). S3: o que é imunossupressor e como funciona. S4: riscos de parar: rejeição aguda vs crônica. S5: cuidados com infecções. S6: CTA 'Tem dúvida sobre o pós-transplante? Manda mensagem.'",
     "—","Banco"),
    (17,"Doação de Órgãos","Doação de órgãos pós-morte: o que realmente acontece","Reels","TOPO",
     "Responder a dúvida mais íntima sobre doação — o que acontece com o corpo — de forma respeitosa e clara, removendo a barreira do desconhecimento.",
     "\"O corpo fica desfigurado depois da doação?\" É a pergunta que ninguém tem coragem de fazer em voz alta. Mas todo mundo quer saber. Aqui está a resposta.",
     "Reels ≤60s. Abordar a dúvida com respeito e clareza. A captação é feita em centro cirúrgico com todos os protocolos. O corpo é tratado com respeito. Velório aberto é possível. Tom: acolhedor, sem tabu. CTA: 'Compartilha com quem tem essa dúvida — pode ser o que falta para uma decisão.'",
     "—","Banco"),
    (18,"Conscientização Cardiovascular","Doença cardiovascular mata mais do que qualquer outra no Brasil","Post único","TOPO",
     "Impactar o público com a dimensão real da mortalidade cardiovascular — criar urgência para prevenção e consulta especializada.",
     "A maior assassina do Brasil não é o câncer. Não é a violência. É a doença cardiovascular. E ela é em grande parte prevenível.",
     "Post único com infográfico impactante: número de mortes por doença cardiovascular/ano vs outras causas. Dado: % que poderia ser prevenida com rastreamento e mudança de estilo de vida. Tom: urgente, direto, mobilizador — sem catastrofismo. CTA: 'Salva e compartilha — esse número precisa mudar.'",
     "—","Banco"),
    (19,"Transplante Cardíaco","Como é a cirurgia de transplante cardíaco?","Reels","MEIO",
     "Desmistificar a cirurgia de transplante — muitos pacientes e familiares têm medo do procedimento por desconhecimento, e a informação clara reduz ansiedade e aumenta confiança.",
     "A cirurgia dura entre 4 e 6 horas. O novo coração começa a bater na mesa cirúrgica. O que acontece nesse meio tempo — eu vou te explicar.",
     "Reels ≤60s. Narração visual em linguagem leiga: anestesia, circulação extracorpórea, implante do novo coração, primeiros batimentos. Sem termos técnicos desnecessários. Tom: informativo e esperançoso. CTA: 'Salva esse post — pode ser informação valiosa para alguém na sua vida.'",
     "—","Banco"),
    (20,"Conscientização Cardiovascular","1 em cada 10 pacientes na fila recebe um coração. Por quê?","Carrossel","TOPO",
     "Mostrar a disparidade entre demanda e oferta de corações para transplante — criar consciência sobre a escassez real e a urgência da declaração de doação.",
     "No Brasil, só 1 em cada 10 pacientes que precisam de um coração novo chega a receber. Você sabia disso?",
     "Carrossel 5 slides. S1: dado de impacto. S2: número de transplantes realizados/ano vs pacientes em fila. S3: por que a diferença é tão grande (baixa taxa de doação vs potencial). S4: o que mudaria com mais doadores declarados. S5: CTA 'Declare-se doador agora e conta para sua família.'",
     "—","Banco"),
]

# ══════════════════════════════════════════════════════════════════════════════
# HUMANIZAÇÃO — (num, subtema, titulo, formato, funil, objetivo, gancho, orientacoes, serie, mes)
# ══════════════════════════════════════════════════════════════════════════════

HUM = [
    (1,"Congressos & Eventos","SOCESP 2026: o que aprendi e o que levo para os meus pacientes","Reels","TOPO",
     "Humanizar a médica mostrando atualização científica contínua — reforçar posicionamento de especialista atualizada sem parecer institucional.",
     "Fui ao SOCESP e voltei com novidades que vão mudar o jeito que cuido dos meus pacientes. Deixa eu te contar.",
     "Reels ≤60s. Bastidores do congresso (auditório, crachá, material). Destacar 1–2 novidades relevantes para pacientes com IC em linguagem leiga. Tom: entusiasmado, de especialista que gosta do que faz. CTA: 'Comenta o que você quer saber sobre novidades em cardiologia.'",
     "—","Banco"),
    (2,"Congressos & Eventos","Congresso Brasileiro de Cardiologia: bastidores e novidades","Post único","TOPO",
     "Reforçar autoridade científica e mostrar comprometimento com atualização — conectar o conteúdo do congresso com o benefício direto para o paciente.",
     "Estou no maior congresso de cardiologia do Brasil. E já tenho novidades para trazer pra você.",
     "Post único com foto no congresso (crachá, auditório ou bastidores). Legenda: breve resumo de 1–2 aprendizados e como impactam os pacientes. Tom: presença real, não corporativo. CTA: 'Me manda sua dúvida — posso perguntar pra um especialista aqui.'",
     "—","Banco"),
    (3,"Congressos & Eventos","Congresso de Medicina do Estilo de Vida: o que há de novo na ciência do comportamento","Carrossel","TOPO",
     "Conectar a Paôla ao movimento de medicina do estilo de vida — posicionar como cardiologista que integra evidências de comportamento saudável ao cuidado cardiovascular.",
     "Fui ao congresso de Medicina do Estilo de Vida. E saí de lá confirmando que o que prescrevemos vai muito além dos remédios.",
     "Carrossel 5 slides. S1: gancho. S2: 1 estudo apresentado sobre exercício e coração. S3: 1 estudo sobre sono e mortalidade. S4: perspectiva clínica — o que isso muda na consulta. S5: CTA 'Compartilha com quem precisa ouvir que estilo de vida é medicina.'",
     "—","Banco"),
    (4,"Atividade Física & Corrida","Fui correr no fim de semana — e o coração agradeceu","Reels","TOPO",
     "Usar a prática pessoal de corrida para reforçar a mensagem de que exercício é medicina — humanizar a médica e engajar o público ativo.",
     "Antes de ser cardiologista, sou humana. E esse final de semana eu lembrei por que exercício é o melhor remédio que eu conheço.",
     "Reels ≤60s. Imagem ou vídeo da corrida com gancho cardiovascular real: frequência cardíaca, respiração, sensação. Conectar experiência pessoal ao que ela prescreve para pacientes. Tom: autêntico, não performático. CTA: 'Me conta: você se moveu essa semana?'",
     "—","Banco"),
    (5,"Atividade Física & Corrida","Minha semana de treino — e o que cada sessão faz pelo coração","Carrossel","TOPO",
     "Compartilhar rotina de exercícios pessoal conectada a dados cardiovasculares — engajar público ativo e reforçar que a médica pratica o que prescreve.",
     "Você me pergunta o que eu faço para cuidar do meu próprio coração. Aqui está a minha semana de treino — com dados reais.",
     "Carrossel 5 slides. S1: gancho. S2–4: 3 treinos da semana com dado cardiovascular de cada (ex: 'corrida 5km — zona 2 → melhora VO2max'). S5: reflexão 'prescrevo para meus pacientes o que eu mesma pratico'. CTA: 'Salva e tenta montar a sua semana.'",
     "—","Banco"),
    (6,"Vida Pessoal & Marcos","Mais um ano: o que esse ciclo me ensinou como médica e como pessoa","Reels","TOPO",
     "Humanizar a marca em data especial — conectar reflexão pessoal ao propósito profissional de forma autêntica, sem deixar de reforçar posicionamento médico.",
     "Hoje é meu aniversário. E no dia em que a gente para para olhar para trás, fica mais fácil entender por que escolhemos os caminhos que escolhemos.",
     "Reels ≤60s. Tom pessoal e reflexivo. 1–2 aprendizados do ano conectados ao trabalho com IC e transplante. Não precisa de produção elaborada — autenticidade importa mais. CTA: 'Manda uma mensagem se você quiser. Estou aqui por causa de vocês.'",
     "—","Banco"),
    (7,"Bastidores","Uma manhã no ambulatório de pós-transplante: o que acontece lá dentro","Reels","TOPO",
     "Mostrar o cotidiano do acompanhamento pós-transplante de forma humana — posicionar a Paôla como especialista presente no pós-operatório, não só na indicação.",
     "Hoje atendi 8 pacientes transplantados. Todos com histórias diferentes. Todos com o mesmo coração renovado. Deixa eu te contar como é essa manhã.",
     "Reels ≤60s. Bastidores respeitosos sem identificar pacientes: consultório, avaliação, dinâmica. O que se discute: ajuste de imunossupressor, qualidade de vida, restrições progressivas. Tom: íntimo, presente, humano. CTA: 'Salva e compartilha com quem passou por transplante.'",
     "—","Banco"),
    (8,"Bastidores","Bastidores do Hospital Albert Einstein: como é um dia de trabalho","Post único","TOPO",
     "Humanizar o ambiente de trabalho e reforçar a associação com uma instituição de excelência — aumentar confiança sem parecer institucional.",
     "Cheguei no Einstein às 7h. Saí às 14h. Entre esses dois horários, aconteceu muita coisa.",
     "Post único com foto do ambiente (corredor ou consultório — sem pacientes). Legenda: narrativa de um dia real, sem romantizar. O que é difícil, o que é gratificante. Tom: honesto e humano. CTA: 'Conta nos comentários: qual foi seu maior desafio essa semana?'",
     "—","Banco"),
    (9,"Atividade Física & Corrida","Por que uma cardiologista corre? (Não é o que você pensa)","Reels","TOPO",
     "Conectar prática pessoal de corrida com saúde mental e cardiovascular — usar gancho de curiosidade para reforçar mensagem de exercício e humanizar a médica.",
     "Não corro porque sou cardiologista. Sou cardiologista porque entendo o que o movimento faz com a gente — e não consigo não fazer.",
     "Reels ≤60s. Tom introspectivo e genuíno. Conectar motivação pessoal (energia, saúde mental, longevidade) com o que ela prescreve para os pacientes. Sem performance — autenticidade. CTA: 'Compartilha com alguém que ainda está procurando uma razão para começar a se mover.'",
     "—","Banco"),
    (10,"Vida Pessoal & Marcos","Quando foi a última vez que você cuidou de você?","Carrossel","TOPO",
     "Abordar o autocuidado como espelho para o paciente — criar identificação e reforçar que cuidar da saúde é uma prática contínua, não um evento.",
     "Eu cuido do coração dos outros todos os dias. E às vezes preciso parar e lembrar de cuidar do meu também. Você se identifica?",
     "Carrossel 4 slides. S1: gancho pessoal. S2: 3 práticas que ela mantém (sono, exercício, pausas). S3: reflexão 'se eu não me cuido, não consigo cuidar bem'. S4: CTA 'Compartilha com alguém que também precisa ouvir isso.'",
     "—","Banco"),
    (11,"Vida Pessoal & Marcos","O que os meus pacientes me ensinaram esse ano","Reels","TOPO",
     "Criar conexão emocional e autenticidade — usar narrativa reversa (paciente ensinando o médico) para humanizar a relação e reforçar o propósito da especialidade.",
     "Eles vêm para que eu os ensine. Mas os meus pacientes de IC avançada me ensinam mais do que qualquer livro.",
     "Reels ≤60s. Tom reflexivo e emocionado, sem identificar pacientes. 2–3 aprendizados concretos: sobre resiliência, sobre prioridades, sobre o valor da presença. Encerrar com propósito: 'é por isso que escolhi essa especialidade'. CTA: 'Compartilha com alguém que te inspira todo dia.'",
     "—","Banco"),
    (12,"Congressos & Eventos","Apresentei no congresso: o que sinto antes de subir no palco","Post único","TOPO",
     "Humanizar o backstage da vida acadêmica — mostrar que por trás da especialista existe uma pessoa que também sente nervosismo e prepara cada detalhe com cuidado.",
     "Antes de subir no palco para falar de IC avançada para 500 cardiologistas, meu coração também acelera.",
     "Post único com foto nos bastidores (antes da apresentação — crachá, telão, anotações). Legenda: 1 parágrafo humano sobre como é se preparar para uma aula num congresso. Tom: autêntico e confiante. CTA: 'O que você faz quando precisa se preparar para algo grande?'",
     "—","Banco"),
    (13,"Atividade Física & Corrida","Minha rotina de exercícios — e o que cada hábito protege","Reels","TOPO",
     "Mostrar consistência e conexão entre prática pessoal e conhecimento médico — reforçar que exercício é prescrição ao vivo, não teoria.",
     "Não prescreveria exercício para meus pacientes se não acreditasse nele primeiro. Aqui está o que eu faço — e por quê.",
     "Reels ≤60s. Mostrar elementos reais da rotina (caminhada, corrida, academia). Para cada hábito: 1 benefício cardiovascular em linguagem leiga. Tom: natural e prático, sem julgamento. CTA: 'Salva e me conta: qual hábito você já tem?'",
     "—","Banco"),
    (14,"Congressos & Eventos","Voltei do congresso com 3 novidades que todo paciente com IC deveria saber","Carrossel","MEIO",
     "Traduzir novidades científicas do congresso em informação útil para pacientes — reforçar autoridade e comprometimento com atualização clínica.",
     "Estive no congresso. Voltei com 3 novidades que qualquer paciente com IC deveria saber.",
     "Carrossel 5 slides. S1: gancho. S2–4: 1 novidade por slide (medicamento, dispositivo ou diretriz) explicada em linguagem leiga com impacto para o paciente. S5: 'Medicina avança. E eu avanço com ela para te oferecer o melhor.' CTA: 'Salva e compartilha com quem tem IC.'",
     "—","Banco"),
    (15,"Vida Pessoal & Marcos","2026: o que construímos juntos","Reels","TOPO",
     "Fechar o ano com gratidão e propósito — criar conexão com a audiência e preparar o terreno para o início de 2027.",
     "Um ano se foi. Muitas consultas, muitas histórias, muitos aprendizados. E a certeza de que isso que estamos construindo aqui importa.",
     "Reels ≤60s. Compilação de momentos do ano (congresso, corridas, bastidores). Tom reflexivo e grato. Mencionar crescimento da comunidade. CTA: 'Obrigada por estar aqui. Nos vemos em 2027 — com ainda mais conteúdo sobre saúde do coração.'",
     "—","Dezembro"),
    (16,"Atividade Física & Corrida","No quilômetro 8, aprendi algo sobre o coração que nenhum livro me ensinou","Post único","TOPO",
     "Usar a experiência de corrida para criar narrativa emocional conectada ao cuidado cardiovascular — engajar público ativo e reforçar a humanidade da médica.",
     "No quilômetro 8, meu corpo quis parar. Minha cabeça mandou continuar. Meu coração decidiu pelos dois.",
     "Post único com foto da corrida. Legenda: narrativa curta da experiência física com gancho metafórico conectando ao cuidado cardiovascular. Tom: poético e autêntico — sem exibicionismo. CTA: 'Você já teve um momento assim? Conta nos comentários.'",
     "—","Banco"),
    (17,"Vida Pessoal & Marcos","Comecei a meditar — e meu coração agradeceu","Reels","TOPO",
     "Conectar prática de meditação/mindfulness com saúde cardiovascular — ampliar o conceito de medicina do estilo de vida além de exercício e dieta.",
     "Não sou a pessoa mais calma do mundo. Mas aprendi que 10 minutos por dia de silêncio fazem mais pelo coração do que muito remédio.",
     "Reels ≤60s. Tom pessoal e vulnerável. Dado: meditação regular reduz PA e marcadores inflamatórios. Prática dela: como começou, qual método. Tom: acessível, sem esoterismo. CTA: 'Você já tentou? Conta nos comentários.'",
     "—","Banco"),
    (18,"Bastidores","Nos bastidores de um plantão de IC avançada","Reels","TOPO",
     "Mostrar a intensidade e o significado do trabalho com IC avançada — humanizar a médica e criar conexão emocional mostrando o propósito por trás da especialidade.",
     "Às 3 da manhã, meu paciente estava instável. Às 6h, estávamos sorrindo juntos. Isso é IC avançada.",
     "Reels ≤60s. Narrativa de um momento marcante do plantão (sem identificar paciente). O que passa pela cabeça, o que é difícil, o que faz valer. Tom: honesto, emocionado sem ser sentimental. CTA: 'Compartilha com quem você admira pelo trabalho que faz.'",
     "—","Banco"),
    (19,"Atividade Física & Corrida","Sou cardiologista e pratico esportes — os dois papéis se completam","Carrossel","TOPO",
     "Integrar identidade profissional e pessoal para criar uma marca autêntica — mostrar que a médica vive o que prescreve.",
     "Quando eu corro, não paro de ser cardiologista. E quando atendo, não paro de ser atleta. Os dois me fazem melhor.",
     "Carrossel 4 slides. S1: gancho. S2: como o esporte me torna mais empática com pacientes que tentam se exercitar. S3: o que o esporte me ensina sobre fisiologia cardiovascular na prática. S4: CTA 'Compartilha com alguém que integra saúde na rotina.'",
     "—","Banco"),
    (20,"Bastidores","Como preparo o conteúdo que publico aqui","Reels","TOPO",
     "Mostrar o cuidado e a seriedade por trás da produção de conteúdo médico — criar confiança e diferenciar do conteúdo raso que circula nas redes sociais.",
     "Antes de publicar qualquer coisa aqui, eu reviso referências, escolho as palavras e pergunto: isso vai ajudar meu paciente? Se a resposta for não, não vai.",
     "Reels ≤60s. Bastidores reais: anotações, roteiro, materiais de referência. Explicar o critério: evidência científica + linguagem acessível + sem sensacionalismo. Tom: transparente e comprometido. CTA: 'Me conta: o que você quer que eu fale aqui que eu ainda não falei?'",
     "—","Banco"),
]

# ══════════════════════════════════════════════════════════════════════════════
# STORIES — (num, subtema, titulo, formato, funil, objetivo, gancho, orientacoes, serie, mes)
# Formato: "Story · Enquete" | "Story · Quiz" | "Story · Caixinha" | "Story · Slider" | "Story · Sequência"
# Proporção: MEV 40% (20) · Conversão 26% (13) · Causa 20% (10) · Humanização 14% (7)
# ══════════════════════════════════════════════════════════════════════════════

STORIES_MEV = [
    (1,"Exercício Físico","Você pratica exercício com regularidade?","Story · Enquete","TOPO",
     "Identificar o comportamento do público e abrir conversa sobre atividade física cardiovascular",
     "Vou te perguntar direto: você se exercita toda semana?",
     "Enquete com 2 opções: 'Sim, toda semana 💪' / 'Nem tanto... 😅'. Story de resposta: dado de impacto sobre sedentarismo ('ficar sentado 8h/dia aumenta risco cardiovascular como fumar') + CTA para agendar avaliação.",
     "—","Abril"),
    (2,"Exercício Físico","Quiz: seu coração está em boa forma?","Story · Quiz","MEIO",
     "Engajar o público com autoteste de aptidão cardiovascular e criar desejo de avaliação especializada",
     "Você sabe se o seu coração está em forma? Um teste rápido.",
     "Quiz 3 perguntas: 'Você sobe escadas sem falta de ar?' / 'Sabe medir sua frequência cardíaca?' / 'Treina quantos minutos por semana?' Resultado final: perfil de aptidão em linguagem leiga + CTA: 'Agende sua avaliação cardiovascular.'",
     "—","Junho"),
    (3,"Nutrição & Dieta","Você sabe quanto sal consome por dia?","Story · Slider","TOPO",
     "Criar consciência sobre consumo excessivo de sódio de forma lúdica antes do post sobre dieta DASH",
     "Desliza o emoji para mostrar o quanto de sal você acha que coloca na comida 🧂",
     "Slider de 'Pouquinho' a 'Muito'. Story de resposta: 'A maioria das pessoas consume 2× o limite recomendado pela OMS sem perceber.' Link para o post do feed sobre dieta DASH.",
     "—","Agosto"),
    (4,"Fatores de Risco","Você sabe sua pressão arterial de hoje?","Story · Enquete","TOPO",
     "Identificar quantos seguidores monitoram a PA e criar urgência para quem não monitora",
     "Última vez que você mediu sua pressão: quando foi?",
     "Enquete: 'Essa semana ✅' / 'Faz tempo... 😬'. Para quem votou 'Faz tempo': sequência com alerta sobre hipertensão silenciosa ('1 em 3 brasileiros não sabe que tem') + CTA para checkup.",
     "—","Janeiro"),
    (5,"Sono & Estresse","Quantas horas você dorme por noite?","Story · Slider","TOPO",
     "Revelar que a maioria do público dorme menos do que o coração precisa e criar gancho para post sobre sono",
     "Desliza para marcar quantas horas você costuma dormir 💤",
     "Slider de 4h a 10h. Story de resposta: 'Se você marcou menos de 7h, seu coração está trabalhando em déficit — vou te explicar por quê.' Link para post do feed sobre sono e coração.",
     "—","Agosto"),
    (6,"Exames & Diagnóstico","Você fez checkup cardiológico em 2025?","Story · Enquete","TOPO",
     "Identificar lacuna de rastreamento e gerar CTA de agendamento com urgência",
     "Pergunta rápida e importante:",
     "Enquete: 'Sim, tudo em dia ✅' / 'Não, ainda não ❌'. Para quem votou Não: sequência com por que o checkup é urgente ('a maioria das doenças cardíacas não dói até ser tarde') + CTA: 'Agende — Einstein, São Luiz Itaim, Dante Pazzanese.'",
     "—","Abril"),
    (7,"Doenças Cardiovasculares","Quiz: você reconhece os sinais de infarto?","Story · Quiz","TOPO",
     "Testar o conhecimento sobre sintomas atípicos e ampliar consciência de alerta cardiovascular",
     "Você saberia reconhecer um infarto — mesmo sem dor no peito?",
     "Quiz 4 perguntas sobre sintomas atípicos (dor no braço, náusea, suor frio, falta de ar isolada). Resultado: 'Infarto não é sempre dor no peito — 40% dos casos têm sintomas atípicos.' CTA: compartilhar com a família.",
     "—","Setembro"),
    (8,"Fatores de Risco","Você tem algum desses fatores de risco?","Story · Enquete","TOPO",
     "Mapear o perfil de risco dos seguidores e criar urgência de acompanhamento",
     "Marque se você tem:",
     "Enquete: 'Pressão alta / Diabetes / Colesterol alto' vs 'Nenhum (por enquanto)'. Story de resposta: risco cumulativo em linguagem leiga ('com 2 fatores, seu risco já é 4×') + CTA para avaliação cardiovascular.",
     "—","Janeiro"),
    (9,"Nutrição & Dieta","Mito ou Verdade: vinho tinto faz bem ao coração?","Story · Enquete","TOPO",
     "Engajar com desinformação comum e corrigir o mito de forma leve e direta",
     "Você já ouviu isso? Mito ou Verdade:",
     "Enquete: '🍷 Verdade!' / '🚫 Mito!'. Story de resposta: Mito — explicar revisão das diretrizes recentes ('a ciência mudou de ideia') sem julgamento. CTA: ver Reels completo sobre álcool e coração no feed.",
     "Mito ou Verdade? 🫀","Dezembro"),
    (10,"Exercício Físico","Qual é o seu maior obstáculo para se exercitar?","Story · Caixinha","TOPO",
     "Coletar objeções reais do público e usar as respostas para criar conteúdo futuro personalizado",
     "Me conta: o que te impede de se exercitar mais?",
     "Caixinha de texto aberta. Responder as mais comuns em stories seguintes com soluções práticas ('falta de tempo → 3 × 10 min funciona', 'medo de machucar → preciso de avaliação antes'). Tom: curiosidade genuína, zero julgamento.",
     "Pergunte à Dra. Paôla 🩺","Maio"),
    (11,"Sono & Estresse","Você acorda descansado todos os dias?","Story · Enquete","MEIO",
     "Criar abertura para falar sobre apneia do sono e qualidade do sono cardiovascular",
     "Resposta honesta:",
     "Enquete: 'Sim, acordo renovado 😴✅' / 'Não, acordo cansado 😵'. Para quem acorda cansado: sequência sobre apneia obstrutiva e risco cardíaco ('ronco + cansaço = coração sob pressão à noite'). CTA para avaliação.",
     "—","Agosto"),
    (12,"Exames & Diagnóstico","Você sabe para que serve o ECG?","Story · Quiz","MEIO",
     "Educar sobre exame básico de cardiologia e gerar valor antes do post sobre ECG no feed",
     "Quiz: o eletrocardiograma serve para...",
     "Quiz 4 opções: a) Medir colesterol / b) Ver estrutura do coração / c) Registrar atividade elétrica / d) Medir pressão arterial. Resposta: c, com explicação simples ('como uma impressão do ritmo elétrico do coração'). CTA: ver carrossel sobre ECG.",
     "—","Agosto"),
    (13,"Doenças Cardiovasculares","Você já sentiu o coração bater diferente?","Story · Caixinha","MEIO",
     "Coletar relatos reais e criar abertura para educar sobre arritmias e quando se preocupar",
     "Uma pergunta que me fazem muito: 'Dra., sinto o coração pular um batimento — é perigoso?'",
     "Caixinha: 'Você já sentiu isso? Me conta como foi.' Story de resposta: explicação sobre extrassístoles benignas vs sinais de alerta ('palpitação isolada ≠ taquicardia sustentada'). CTA para avaliação se sintoma for frequente.",
     "Pergunte à Dra. Paôla 🩺","Maio"),
    (14,"Nutrição & Dieta","Qual desses você acha mais saudável para o coração?","Story · Quiz","TOPO",
     "Testar percepções alimentares e corrigir crenças incorretas de forma interativa",
     "Dois alimentos. Qual é melhor para o coração?",
     "Quiz comparativo em 3 rodadas: manteiga vs azeite / ovo vs biscoito diet / suco de laranja vs laranja in natura. Explicação cardiológica curta em cada resposta. CTA: salvar e aplicar na próxima compra.",
     "—","Agosto"),
    (15,"Fatores de Risco","Qual fator de risco você ainda não controla?","Story · Caixinha","MEIO",
     "Abrir espaço de vulnerabilidade para gerar conexão e embasar conteúdo personalizado futuro",
     "Posso te perguntar algo? Sabe aquele fator de risco que você já sabe que existe mas ainda não resolveu?",
     "Caixinha aberta. Responder as mais frequentes em próximos stories com caminho prático de solução. Tom: sem julgamento — 'a maioria de nós tem um'. CTA: 'Esse é o primeiro passo — reconhecer.'",
     "—","Novembro"),
    (16,"Exercício Físico","Você conseguiria caminhar 30 minutos hoje?","Story · Enquete","TOPO",
     "Remover barreira do público sedentário e motivar ação imediata com mínimo de fricção",
     "Você sabia que caminhar 30 minutos por dia já protege o coração?",
     "Enquete: 'Sim, vou fazer hoje! 👟' / 'Difícil, não tenho tempo ⏱️'. Para quem votou 'Difícil': dicas rápidas de como encaixar caminhada na rotina ('3 × 10 min tem o mesmo efeito'). CTA: começar com 15 minutos amanhã.",
     "—","Janeiro"),
    (17,"Doenças Cardiovasculares","Sequência: 5 sinais que o coração manda antes de um infarto","Story · Sequência","TOPO",
     "Educar sobre sintomas precursores e motivar busca por avaliação cardiológica",
     "Você conhece os avisos que o coração dá antes de um infarto?",
     "5 stories sequenciais, 1 sinal por story: 1) Dor no peito ao esforço — 'que passa em repouso' 2) Falta de ar desproporcional 3) Cansaço incomum 4) Palpitações frequentes 5) Dor em braço, mandíbula ou costas. Último story: 'Se você tem algum — não espera. CTA: agendar urgente.'",
     "—","Setembro"),
    (18,"Sono & Estresse","Quanto estresse você sente no dia a dia?","Story · Slider","TOPO",
     "Dimensionar o nível de estresse do público e conectar ao risco cardiovascular com gancho emocional",
     "Desliza para mostrar seu nível de estresse hoje 😤",
     "Slider de '😌 Tranquilo' a '🤯 Explodindo'. Story de resposta: 'Se você deslizou pro lado direito — seu coração sente isso. Cortisol elevado inflama as artérias.' CTA: ver post sobre Takotsubo e estresse no feed.",
     "—","Fevereiro"),
    (19,"Exames & Diagnóstico","Você sabia que existe pressão do jaleco branco?","Story · Enquete","TOPO",
     "Educar sobre hipertensão do jaleco branco e valorizar o MAPA como exame de rastreamento",
     "Sua pressão sobe só de entrar no consultório? Tem nome para isso:",
     "Enquete: 'Sim, acontece comigo! 😅' / 'Não sabia disso 😮'. Próximo story: explicar 'hipertensão do jaleco branco' e quando pedir MAPA ('a pressão real do dia a dia pode ser diferente'). CTA: perguntar ao cardiologista.",
     "—","Abril"),
    (20,"Nutrição & Dieta","Um hábito alimentar que você quer mudar — me conta","Story · Caixinha","TOPO",
     "Coletar dados reais de comportamento alimentar para embasar próximos conteúdos sobre nutrição cardiovascular",
     "Sem julgamento: qual hábito alimentar você sabe que precisa mudar mas ainda não conseguiu?",
     "Caixinha aberta. Responder com encorajamento + dica prática baseada nas respostas mais frequentes (sal, açúcar, ultraprocessados). Tom: aliança, não cobrança. CTA: 'Uma troca por semana já conta.'",
     "—","Outubro"),
]

STORIES_CONV = [
    (1,"Apresentação & Posicionamento","Me deixa me apresentar — nova fase em SP","Story · Sequência","FUNDO",
     "Apresentar a Paôla de forma humanizada e direta para novos seguidores no lançamento do perfil",
     "Nova por aqui? Deixa eu me apresentar em 30 segundos.",
     "4 stories: 1) Nome + especialidade IC avançada e transplante 2) Onde atendo (Einstein, São Luiz Itaim, Dante Pazzanese) 3) Por que escolhi essa especialidade em 1 frase 4) CTA: 'Me segue — todo conteúdo que eu publico é sobre proteger o seu coração.'",
     "—","Abril"),
    (2,"Onde Atendo & Agenda","Como agendar sua consulta comigo — passo a passo","Story · Sequência","FUNDO",
     "Eliminar a fricção do agendamento com informações práticas claras e acessíveis",
     "Pergunta que recebo muito: como agendar consulta com você?",
     "3 stories: 1) Onde atendo + canal de agendamento em cada hospital 2) O que levar na primeira consulta (exames, lista de medicamentos) 3) CTA: 'Dúvida? Me manda mensagem — te ajudo.'",
     "—","Junho"),
    (3,"Diferenciais & Especialidade","Cardiologista e especialista em IC são a mesma coisa?","Story · Enquete","FUNDO",
     "Criar consciência sobre subespecialização e gerar desejo de consulta com a especialista certa",
     "Cardiologista geral e especialista em IC avançada são a mesma coisa?",
     "Enquete: 'Sim, é tudo igual 🤷' / 'Não, são diferentes 🎯'. Próximo story: 'São muito diferentes — e se você tem IC, essa diferença muda tudo.' Explicação em 3 linhas + CTA: 'Agende com quem é especialista.'",
     "—","Agosto"),
    (4,"Primeira Consulta","O que você quer saber antes da sua 1ª consulta?","Story · Caixinha","FUNDO",
     "Coletar dúvidas reais sobre o processo de consulta e reduzir barreiras de agendamento",
     "Vou responder: o que você quer saber sobre a primeira consulta comigo?",
     "Caixinha aberta. Responder dúvidas em stories seguintes (duração, o que trazer, se pode trazer familiar). Tom: acolhedor. CTA no final: 'Pronto para agendar? Link na bio.'",
     "Pergunte à Dra. Paôla 🩺","Julho"),
    (5,"Q&A & Engajamento","Manda sua dúvida sobre o coração","Story · Caixinha","FUNDO",
     "Gerar engajamento direto e coletar perguntas para o carrossel de Q&A do feed",
     "Caixa de perguntas aberta: o que você sempre quis perguntar pra uma cardiologista?",
     "Caixinha aberta. Responder as melhores no feed (Carrossel Q&A) e em próximos stories. Tom: 'nenhuma pergunta é boba'. CTA: 'Manda — pode virar o próximo post do feed.'",
     "Pergunte à Dra. Paôla 🩺","Outubro"),
    (6,"Q&A & Engajamento","Quiz: você me conhece bem?","Story · Quiz","FUNDO",
     "Engajar seguidores antigos e novos com conteúdo leve sobre trajetória e especialidade",
     "Quiz rápido sobre mim — você me conhece?",
     "4 perguntas: especialidade principal / onde atendo / foco de tratamento (IC avançada e Tx) / série de conteúdo do perfil. Resultado: 'Você me conhece bem! / Tem muito mais pra descobrir — me segue 💙'. CTA: seguir.",
     "—","Outubro"),
    (7,"Diferenciais & Especialidade","IC avançada sem especialista? Você precisa ouvir isso","Story · Enquete","FUNDO",
     "Qualificar pacientes com IC e gerar urgência de consulta especializada",
     "Para quem tem insuficiência cardíaca: você está sendo acompanhado por um especialista em IC?",
     "Enquete: 'Sim, tenho especialista ✅' / 'Não, só clínico ou cardiologista geral 😕'. Para quem votou Não: explicação urgente em 2 stories ('IC avançada exige protocolo específico — o Quarteto Fantástico salva vidas') + CTA direto de agendamento.",
     "—","Agosto"),
    (8,"Onde Atendo & Agenda","Dia Mundial do Coração: você já cuidou do seu?","Story · Enquete","FUNDO",
     "Usar o Dia Mundial do Coração (29/set) para gerar CTA de agendamento com urgência emocional",
     "Hoje é o Dia Mundial do Coração. Eu preciso te perguntar:",
     "Enquete: 'Sim, estou cuidando do meu ❤️' / 'Ainda não agendei 😬'. Para quem não agendou: sequência 2 stories — motivo para não adiar + link de agendamento direto (Einstein, São Luiz Itaim, Dante Pazzanese). Publicar 29/set.",
     "—","Setembro"),
    (9,"Q&A & Engajamento","Qual sintoma do coração mais te preocupa?","Story · Caixinha","FUNDO",
     "Qualificar leads com sintomas que demandam avaliação especializada e abrir canal de DM",
     "Você pode me contar? Qual sintoma relacionado ao coração mais te preocupa hoje?",
     "Caixinha aberta. Responder nos DMs com orientação individualizada + CTA para consulta. Tom: acolhedor, não alarmista. 'Nenhum sintoma deve ser ignorado — me conta que eu te oriento.'",
     "—","Outubro"),
    (10,"Apresentação & Posicionamento","Por que escolhi IC avançada — em 4 stories","Story · Sequência","FUNDO",
     "Humanizar a marca e construir conexão emocional que motiva o agendamento",
     "Vou te contar a história por trás da minha especialidade.",
     "4 stories: 1) Trajetória pessoal (formação) 2) Momento de decisão pela IC avançada 3) O que me motiva ('cuidar de quem o coração não consegue mais sozinho') 4) Propósito + CTA: 'É por isso que estou aqui — e por isso vou cuidar de você.'",
     "—","Novembro"),
    (11,"Onde Atendo & Agenda","Você sabia onde me encontrar em SP?","Story · Sequência","FUNDO",
     "Apresentar os hospitais como referências de confiança e facilitar o agendamento",
     "Deixa eu te mostrar onde você vai encontrar a Dra. Paôla:",
     "3 stories: Einstein → São Luiz Itaim → Dante Pazzanese. Cada story: foto do hospital + especialidade atendida + como agendar. CTA final: 'Qualquer dúvida, me manda mensagem — te ajudo a escolher o mais perto de você.'",
     "—","Junho"),
    (12,"Onde Atendo & Agenda","Agende seu checkup 2027 — agenda de janeiro abre agora","Story · Sequência","FUNDO",
     "Criar urgência positiva de fim de ano para preencher agenda de janeiro 2027",
     "Dezembro chegou — e o coração trabalhou 365 dias sem parar.",
     "3 stories: 1) Dado sobre importância do checkup anual 2) O que é avaliado na consulta cardiovascular 3) CTA direto: 'Agende agora para janeiro — Einstein, São Luiz Itaim, Dante Pazzanese. Link na bio.'",
     "—","Dezembro"),
    (13,"Q&A & Engajamento","Sua família tem histórico cardíaco? Me conta","Story · Caixinha","FUNDO",
     "Abrir conversa sobre histórico familiar e qualificar potenciais pacientes de rastreamento precoce",
     "Pergunta importante: alguém na sua família já teve infarto, IC ou transplante?",
     "Caixinha aberta. Responder com orientação: 'Quem tem histórico familiar de primeiro grau deve iniciar rastreamento 10 anos antes da idade do familiar afetado.' CTA: agendar avaliação. Tom: cuidado, não alarme.",
     "—","Novembro"),
]

STORIES_CAUSA = [
    (1,"Doação de Órgãos","Você é doador de órgãos?","Story · Enquete","TOPO",
     "Abrir conversa sobre doação e identificar a posição do público para segmentar próximos stories",
     "Uma pergunta que todo cardiologista deveria fazer:",
     "Enquete: 'Sim, sou doador ❤️' / 'Não sou / tenho dúvidas 🤔'. Para quem tem dúvidas: sequência desmistificando os medos mais comuns ('o médico vai me salvar mesmo sendo doador'). CTA: conversar com a família.",
     "—","Setembro"),
    (2,"Doação de Órgãos","Mito ou Verdade: família pode bloquear doação no Brasil?","Story · Enquete","TOPO",
     "Corrigir desinformação crítica sobre o processo de doação de órgãos no Brasil",
     "Mito ou Verdade: família pode recusar a doação mesmo com a pessoa cadastrada como doadora?",
     "Enquete: '🤔 Verdade' / '❌ Mito'. Próximo story: VERDADE — no Brasil a decisão familiar prevalece. 'Por isso conversar com a família é o ato mais importante de ser doador.' CTA: ter essa conversa hoje.",
     "Mito ou Verdade? 🫀","Setembro"),
    (3,"Transplante Cardíaco","Você conhece alguém na fila de espera por um coração?","Story · Enquete","TOPO",
     "Criar conexão emocional com a realidade da fila de espera e motivar a conversa sobre doação",
     "No Brasil, centenas de pessoas esperam por um coração. Você sabe se conhece alguém assim?",
     "Enquete: 'Sim, conheço alguém 💔' / 'Não conheço diretamente'. Story de resposta: dados da fila de espera + apelo à doação. Tom: esperançoso, não pesado. CTA: compartilhar esse story.",
     "—","Agosto"),
    (4,"Doação de Órgãos","Quiz: o que você sabe sobre doação de órgãos?","Story · Quiz","TOPO",
     "Testar conhecimento e desmistificar crenças incorretas sobre doação de forma interativa",
     "Teste rápido: o que você sabe sobre doação de órgãos?",
     "Quiz 4 perguntas: 'Qual é a idade limite para doação?' / 'O que é morte encefálica?' / 'Quem decide a doação no Brasil?' / 'Quantos órgãos uma pessoa pode doar?'. Respostas com explicações em linguagem leiga.",
     "—","Setembro"),
    (5,"Transplante Cardíaco","Sequência: o caminho de um coração doado até o receptor","Story · Sequência","TOPO",
     "Mostrar o processo de doação de forma emocional e educativa para valorizar cada decisão de doação",
     "Você sabe o que acontece nos minutos após a decisão de doar um coração?",
     "5 stories: 1) Diagnóstico de morte encefálica 2) Notificação da família 3) Registro no SNTC e busca do receptor 4) Transporte do órgão (tempo crítico) 5) Cirurgia de implante. Tom: reverente, científico e humanizado.",
     "—","Junho"),
    (6,"Doação de Órgãos","27/set — Dia da Doação: você já falou com sua família?","Story · Caixinha","TOPO",
     "Mobilizar ação concreta no Dia Nacional da Doação de Órgãos (27/set)",
     "Hoje é o Dia Nacional da Doação de Órgãos. Eu tenho um pedido:",
     "Caixinha: 'Me conta — você já conversou com sua família sobre ser doador?' Responder com encorajamento + orientação de como ter essa conversa ('diga na próxima reunião de família'). Publicar 27/set.",
     "—","Setembro"),
    (7,"Transplante Cardíaco","Quiz: quantas pessoas esperam por um coração no Brasil?","Story · Quiz","TOPO",
     "Gerar impacto emocional com dado real sobre a lista de espera e motivar empatia pela causa",
     "Você sabe quantas pessoas aguardam por um transplante de coração hoje?",
     "Quiz com 4 opções de número (verificar dado atualizado no SNTC). Resposta com dado atual + 'Cada doador salva até 8 vidas.' Tom: impactante mas esperançoso. CTA: compartilhar para ampliar a consciência.",
     "—","Agosto"),
    (8,"Doação de Órgãos","Como você convenceria alguém a ser doador?","Story · Caixinha","TOPO",
     "Engajar seguidores que já apoiam doação a multiplicar a mensagem para sua rede",
     "Se você precisasse convencer alguém a ser doador de órgãos, o que você diria?",
     "Caixinha aberta. Compartilhar as respostas mais inspiradoras nos próximos stories (com permissão). CTA: 'Compartilha esse story com quem você quer convencer — uma conversa pode salvar uma vida.'",
     "—","Setembro"),
    (9,"Transplante Cardíaco","Mito ou Verdade: transplante de coração é só para quem tem plano?","Story · Enquete","TOPO",
     "Combater desinformação sobre acesso ao transplante cardíaco pelo sistema público",
     "Mito ou Verdade: transplante de coração no Brasil é só para quem tem plano de saúde particular",
     "Enquete: '💰 Verdade' / '❤️ Mito'. Próximo story: MITO — 'o SUS realiza mais de 90% dos transplantes de coração no Brasil, com centros de referência como o Dante Pazzanese.' Dado de impacto + orgulho do sistema público.",
     "Mito ou Verdade? 🫀","Outubro"),
    (10,"Transplante Cardíaco","Como é a vida depois do transplante de coração?","Story · Caixinha","MEIO",
     "Mostrar que pós-transplante é vida plena e criar esperança para pacientes e familiares",
     "Você tem curiosidade sobre como é a vida de quem recebeu um coração novo?",
     "Caixinha: 'Me manda sua pergunta sobre vida pós-transplante.' Responder com histórias de qualidade de vida real (sem identificação de pacientes, conforme CFM). CTA: seguir para conteúdo sobre pós-Tx no feed.",
     "—","Outubro"),
]

STORIES_HUM = [
    (1,"Congresso / Bastidores","Bastidores: eu estou aqui — vem ver","Story · Sequência","TOPO",
     "Humanizar a marca mostrando a médica em contextos profissionais reais e reforçar atualização constante",
     "Hoje estou no [nome do congresso / ambulatório]. Vou te mostrar um pouco do que acontece aqui.",
     "3-4 stories de bastidores: chegada ao evento / painel ou sessão de casos / momento de aprendizado. Último story: aprendizado do dia em 1 frase acessível + CTA: 'Me segue para acompanhar os próximos congressos.'",
     "—","Banco"),
    (2,"Corrida & Atividade Física","Você toparia correr uma prova comigo?","Story · Enquete","TOPO",
     "Engajar o público com lado humanizado da médica e reforçar lifestyle medicine como exemplo pessoal",
     "Eu corro. E acho que você também deveria. Vem comigo?",
     "Enquete: 'Sim, topo! 🏃' / 'Ainda não me vejo nisso 😅'. Para quem topou: próximo story com dicas de como começar a correr com segurança cardiológica ('sempre com avaliação antes'). Tom: motivador, não elitista.",
     "—","Banco"),
    (3,"Bastidores & Humanização","Qual pergunta você faria pra mim agora?","Story · Caixinha","TOPO",
     "Criar conexão pessoal e coletar perguntas que retroalimentam o conteúdo do perfil",
     "Você tem 1 pergunta pra me fazer — do coração mesmo, nada é proibido.",
     "Caixinha aberta. Tom: leve, pessoal, acessível. Responder as perguntas mais interessantes nos próximos stories ou num Reels. Pode misturar profissional e pessoal — humaniza sem perder autoridade.",
     "Pergunte à Dra. Paôla 🩺","Banco"),
    (4,"Congresso / Bastidores","Aprendi algo hoje que todo mundo deveria saber","Story · Sequência","TOPO",
     "Posicionar a Paôla como médica em constante atualização e compartilhar conhecimento de forma acessível",
     "Dia de congresso. Uma coisa que aprendi hoje e que muda como eu cuido dos meus pacientes:",
     "2-3 stories: 1) Contexto do evento em 1 frase 2) Aprendizado principal em linguagem leiga ('nova evidência sobre...') 3) Como isso impacta o cuidado com o paciente. CTA: 'Salva pra não esquecer.'",
     "—","Banco"),
    (5,"Aniversário / Marco pessoal","Quiz: você me conhece de verdade?","Story · Quiz","TOPO",
     "Engajar seguidores com conteúdo leve e celebrar marco pessoal de forma autêntica",
     "Aniversário chegou — e eu quero saber se você me conhece mesmo 😄",
     "Quiz 5 perguntas sobre trajetória, especialidade, hábitos pessoais, hospitais onde atende. Resultado: 'Você arrasou! / Tem muito mais pra descobrir sobre mim 💙.' CTA: seguir para mais conteúdo. Tom: leveza, gratidão.",
     "—","Banco"),
    (6,"Bastidores & Humanização","Como você cuida do seu coração no dia a dia?","Story · Caixinha","TOPO",
     "Coletar relatos reais do público e gerar conteúdo de comunidade e pertencimento",
     "Sem filtro: me conta um hábito que você faz todo dia que acha que faz bem pro coração.",
     "Caixinha aberta. Compartilhar os melhores (com permissão) em próximos stories com comentário cardiológico rápido ('ótimo hábito porque...'). Tom: comunidade, incentivo, pertencimento.",
     "—","Banco"),
    (7,"Retrospectiva","O que você aprendeu sobre seu coração em 2026?","Story · Caixinha","TOPO",
     "Encerrar o ano criando engajamento emocional e reforçando a jornada do seguidor com a Paôla",
     "Fim de 2026. E eu quero saber: o que você aprendeu sobre cuidar do seu coração esse ano?",
     "Caixinha aberta. Compartilhar as respostas mais bonitas em stories de retrospectiva. CTA: 'Vejo você em 2027 — com mais saúde e mais coração. Obrigada por me acompanhar.' Tom: gratidão e calor humano.",
     "—","Dezembro"),
]

# ── Transformar em lista de dicts ─────────────────────────────────────────────
all_topics = []

for t in MEV:
    all_topics.append({
        "id":         len(all_topics),
        "linha":      "Medicina do Estilo de Vida",
        "subtema":    t[1],
        "titulo":     t[2],
        "formato":    t[3],
        "funil":      t[4],
        "objetivo":   t[5],
        "gancho":     t[6],
        "orientacoes":t[7],
        "serie":      t[8],
        "mes":        t[9],
    })

for t in CONV:
    all_topics.append({
        "id":         len(all_topics),
        "linha":      "Conversão",
        "subtema":    t[1],
        "titulo":     t[2],
        "formato":    t[3],
        "funil":      t[4],
        "objetivo":   t[5],
        "gancho":     t[6],
        "orientacoes":t[7],
        "serie":      t[8],
        "mes":        t[9],
    })

for t in CAUSA:
    all_topics.append({
        "id":         len(all_topics),
        "linha":      "Causa & Conscientização",
        "subtema":    t[1],
        "titulo":     t[2],
        "formato":    t[3],
        "funil":      t[4],
        "objetivo":   t[5],
        "gancho":     t[6],
        "orientacoes":t[7],
        "serie":      t[8],
        "mes":        t[9],
    })

for t in HUM:
    all_topics.append({
        "id":         len(all_topics),
        "linha":      "Humanização",
        "subtema":    t[1],
        "titulo":     t[2],
        "formato":    t[3],
        "funil":      t[4],
        "objetivo":   t[5],
        "gancho":     t[6],
        "orientacoes":t[7],
        "serie":      t[8],
        "mes":        t[9],
    })

for linha_nome, lista in [
    ("Medicina do Estilo de Vida", STORIES_MEV),
    ("Conversão",                  STORIES_CONV),
    ("Causa & Conscientização",    STORIES_CAUSA),
    ("Humanização",                STORIES_HUM),
]:
    for t in lista:
        all_topics.append({
            "id":         len(all_topics),
            "linha":      linha_nome,
            "subtema":    t[1],
            "titulo":     t[2],
            "formato":    t[3],
            "funil":      t[4],
            "objetivo":   t[5],
            "gancho":     t[6],
            "orientacoes":t[7],
            "serie":      t[8],
            "mes":        t[9],
        })

data_json = json.dumps(all_topics, ensure_ascii=False, indent=2)

# ══════════════════════════════════════════════════════════════════════════════
# HTML TEMPLATE
# ══════════════════════════════════════════════════════════════════════════════

HTML = """<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Banco de Temas · @paolapreto · 2026</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',system-ui,sans-serif;background:#F0F4F8;color:#1A202C;font-size:13px}

/* ── LAYOUT ─────────────────────────────────────────────────────── */
.app{display:flex;flex-direction:column;height:100vh;overflow:hidden}
.header{background:#1A3A4A;color:#fff;padding:12px 20px;display:flex;align-items:center;gap:12px;flex-shrink:0;z-index:100;box-shadow:0 2px 8px rgba(0,0,0,.3)}
.header h1{font-size:15px;font-weight:700;white-space:nowrap;letter-spacing:-.3px}
.header .tag{font-size:11px;color:#90CDF4;font-weight:400}
.search-wrap{flex:1;max-width:340px;position:relative}
.search-wrap input{width:100%;padding:7px 12px 7px 32px;border-radius:8px;border:none;background:rgba(255,255,255,.12);color:#fff;font-size:13px;outline:none;transition:.2s}
.search-wrap input::placeholder{color:rgba(255,255,255,.45)}
.search-wrap input:focus{background:rgba(255,255,255,.2)}
.search-icon{position:absolute;left:9px;top:50%;transform:translateY(-50%);opacity:.5;font-size:14px}
.counter{font-size:12px;color:#90CDF4;white-space:nowrap}
.btn{padding:7px 14px;border-radius:7px;border:none;cursor:pointer;font-size:12px;font-weight:600;transition:.15s}
.btn-export{background:#2B6CB0;color:#fff}.btn-export:hover{background:#2C5282}
.btn-reset{background:rgba(255,255,255,.12);color:#FC8181}.btn-reset:hover{background:rgba(252,129,129,.2)}

.body{display:flex;flex:1;overflow:hidden}

/* ── SIDEBAR ─────────────────────────────────────────────────────── */
.sidebar{width:220px;flex-shrink:0;background:#1E3A4C;overflow-y:auto;padding:12px 0}
.sidebar::-webkit-scrollbar{width:4px}.sidebar::-webkit-scrollbar-thumb{background:rgba(255,255,255,.15);border-radius:2px}
.filter-group{margin-bottom:4px}
.filter-title{font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:.08em;color:rgba(255,255,255,.4);padding:10px 16px 5px;cursor:pointer;display:flex;justify-content:space-between;align-items:center;user-select:none}
.filter-title:hover{color:rgba(255,255,255,.7)}
.filter-title .arrow{font-size:9px;transition:.2s}
.filter-title.collapsed .arrow{transform:rotate(-90deg)}
.filter-items{overflow:hidden}
.filter-items.hidden{display:none}
.filter-item{display:flex;align-items:center;gap:8px;padding:4px 16px;cursor:pointer;border-radius:0;transition:.1s}
.filter-item:hover{background:rgba(255,255,255,.07)}
.filter-item input[type=checkbox]{accent-color:#63B3ED;width:13px;height:13px;cursor:pointer;flex-shrink:0}
.filter-item label{font-size:12px;color:rgba(255,255,255,.75);cursor:pointer;flex:1;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.filter-item .count{font-size:10px;color:rgba(255,255,255,.3);flex-shrink:0}
.sidebar-clear{margin:8px 16px 4px;padding:6px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.1);border-radius:6px;color:rgba(255,255,255,.5);font-size:11px;cursor:pointer;width:calc(100% - 32px);text-align:center;transition:.15s}
.sidebar-clear:hover{background:rgba(255,255,255,.1);color:#fff}

/* ── MAIN ─────────────────────────────────────────────────────────── */
.main{flex:1;overflow-y:auto;padding:0;padding-bottom:80px}
.main::-webkit-scrollbar{width:6px}.main::-webkit-scrollbar-thumb{background:#CBD5E0;border-radius:3px}

table{width:100%;border-collapse:collapse;background:#fff}
thead{position:sticky;top:0;z-index:50}
thead tr{background:#2E6B8A}
thead th{padding:9px 10px;text-align:left;font-size:11px;font-weight:700;color:#fff;text-transform:uppercase;letter-spacing:.06em;white-space:nowrap;border-right:1px solid rgba(255,255,255,.1)}
thead th:last-child{border-right:none}

/* column widths */
.col-num{width:42px;text-align:center}
.col-linha{width:62px}
.col-subtema{width:130px}
.col-titulo{width:auto;min-width:220px}
.col-fmt{width:84px}
.col-funil{width:64px}
.col-serie{width:110px}
.col-mes{width:80px}
.col-exp{width:32px;text-align:center}

tbody tr.summary{cursor:pointer;border-bottom:1px solid #EDF2F7;transition:.1s}
tbody tr.summary:hover{background:#EBF8FF}
tbody tr.summary.expanded-row{background:#EBF8FF}
tbody tr.summary td{padding:8px 10px;vertical-align:middle}
.td-num{font-size:11px;color:#A0AEC0;text-align:center;font-weight:700}
.td-titulo{font-weight:600;color:#1A202C;line-height:1.35}
.expand-btn{font-size:14px;color:#A0AEC0;text-align:center;transition:.2s;user-select:none}
.expanded-row .expand-btn{color:#2B6CB0}

tbody tr.detail{display:none}
tbody tr.detail.show{display:table-row}
tbody tr.detail td{padding:0}
.detail-panel{padding:16px 20px;background:#F7FAFC;border-bottom:2px solid #BEE3F8}

.field-block{margin-bottom:14px}
.field-block:last-child{margin-bottom:0}
.field-label{font-size:10px;font-weight:800;text-transform:uppercase;letter-spacing:.08em;color:#718096;margin-bottom:5px}
.field-content{font-size:13px;color:#2D3748;line-height:1.6;padding:6px 8px;border-radius:5px;cursor:pointer;transition:.15s;white-space:pre-wrap;word-break:break-word}
.field-content:hover{background:#E2E8F0}
.field-content.editing{display:none}
.field-textarea{width:100%;min-height:72px;font-size:13px;color:#2D3748;border:2px solid #4299E1;border-radius:5px;padding:6px 8px;resize:vertical;font-family:inherit;line-height:1.6;background:#fff}
.field-hint{font-size:10px;color:#A0AEC0;margin-top:3px}

/* ── BADGES ──────────────────────────────────────────────────────── */
.badge{display:inline-flex;align-items:center;padding:2px 8px;border-radius:999px;font-size:11px;font-weight:700;cursor:pointer;user-select:none;transition:.1s;white-space:nowrap}
.badge:hover{filter:brightness(.93)}

/* Linha */
.badge-linha-mev{background:#D6EAF8;color:#1A5276}
.badge-linha-conv{background:#FDEDEC;color:#922B21}
.badge-linha-causa{background:#D5F5E3;color:#1E8449}
.badge-linha-hum{background:#F4ECF7;color:#76448A}

/* Subtema */
.badge-sub-ef{background:#D6EAF8;color:#1A5276}
.badge-sub-nd{background:#D5F5E3;color:#1E8449}
.badge-sub-fr{background:#FDEDEC;color:#922B21}
.badge-sub-se{background:#F4ECF7;color:#76448A}
.badge-sub-ed{background:#FEF9E7;color:#9A7D0A}
.badge-sub-dc{background:#FDEBD0;color:#A04000}
.badge-sub-ap{background:#FDEDEC;color:#922B21}
.badge-sub-de{background:#F4ECF7;color:#76448A}
.badge-sub-oa{background:#FDEBD0;color:#784212}
.badge-sub-pc{background:#D5F5E3;color:#1E8449}
.badge-sub-qa{background:#FEF9E7;color:#9A7D0A}
.badge-sub-default{background:#EDF2F7;color:#4A5568}

/* Formato */
.badge-fmt-reels{background:#E8DAEF;color:#6C3483}
.badge-fmt-carrossel{background:#D6EAF8;color:#1A5276}
.badge-fmt-post{background:#D5F5E3;color:#1E8449}
.badge-fmt-story{background:#FCE4EC;color:#880E4F}

/* Funil */
.badge-funil-topo{background:#D6EAF8;color:#1A5276}
.badge-funil-meio{background:#FDEBD0;color:#784212}
.badge-funil-fundo{background:#FDEDEC;color:#922B21}

/* Série */
.badge-serie-mv{background:#FFF3CD;color:#856404}
.badge-serie-pq{background:#D1ECF1;color:#0C5460}
.badge-serie-none{background:#F8F9FA;color:#6C757D}

/* Mês */
.badge-mes{background:#EBF8FF;color:#2B6CB0}
.badge-mes-banco{background:#FFF5F5;color:#9B2C2C}

/* ── CUSTOM DROPDOWN ─────────────────────────────────────────────── */
.dp-overlay{position:fixed;inset:0;z-index:499;background:transparent}
.dp-menu{position:fixed;background:#fff;border:1px solid #E2E8F0;border-radius:8px;box-shadow:0 8px 24px rgba(0,0,0,.12);z-index:500;min-width:140px;padding:4px 0;overflow:hidden}
.dp-item{padding:7px 14px;cursor:pointer;font-size:12px;font-weight:600;transition:.1s;display:flex;align-items:center;gap:8px}
.dp-item:hover{background:#EBF8FF}
.dp-item.active{background:#EBF8FF;color:#2B6CB0}

/* ── EMPTY STATE ─────────────────────────────────────────────────── */
.empty{padding:60px 20px;text-align:center;color:#A0AEC0}
.empty .icon{font-size:40px;margin-bottom:12px}
.empty p{font-size:14px}

/* ── SAVE TOAST ──────────────────────────────────────────────────── */
.toast{position:fixed;bottom:20px;right:20px;background:#276749;color:#fff;padding:8px 16px;border-radius:8px;font-size:12px;font-weight:600;opacity:0;transition:opacity .3s;z-index:1000;pointer-events:none}
.toast.show{opacity:1}

/* ── SORT ─────────────────────────────────────────────────────── */
.th-sort{cursor:pointer;user-select:none}
.th-sort:hover{background:#256382}
.sort-ind{margin-left:4px;font-size:9px;opacity:.55;display:inline-block;min-width:10px}

/* ── SELECTION ─────────────────────────────────────────────────── */
.col-check{width:36px;text-align:center}
tbody tr.summary.selected-row{background:#FFFDE7}
tbody tr.summary.selected-row:hover{background:#FFF9C4}

/* ── CART FAB ──────────────────────────────────────────────────── */
.cart-fab{position:fixed;bottom:24px;right:24px;background:#744210;color:#FEFCBF;border:none;border-radius:999px;padding:11px 20px;font-size:14px;font-weight:700;cursor:pointer;box-shadow:0 4px 16px rgba(0,0,0,.3);z-index:700;transition:.2s;display:none}
.cart-fab:hover{background:#5F370E;transform:scale(1.04)}
.cart-fab-count{display:inline-block;background:#fff;color:#744210;border-radius:999px;font-size:11px;font-weight:800;min-width:18px;height:18px;line-height:18px;text-align:center;padding:0 4px;margin-left:6px}

/* ── CART DRAWER ───────────────────────────────────────────────── */
.drawer-overlay{position:fixed;inset:0;background:rgba(0,0,0,.35);z-index:800;display:none}
.cart-drawer{position:fixed;right:0;top:0;bottom:0;width:400px;background:#fff;z-index:810;display:flex;flex-direction:column;box-shadow:-4px 0 32px rgba(0,0,0,.18);transform:translateX(100%);transition:transform .25s ease}
.cart-drawer.open{transform:translateX(0)}
.cart-hdr{background:#1A3A4A;color:#fff;padding:14px 16px;display:flex;justify-content:space-between;align-items:center;flex-shrink:0}
.cart-hdr h3{font-size:14px;font-weight:700}
.cart-close-btn{background:none;border:none;color:#fff;font-size:20px;cursor:pointer;line-height:1;opacity:.7;padding:0 4px}
.cart-close-btn:hover{opacity:1}
.cart-items{flex:1;overflow-y:auto;padding:4px 0}
.cart-item{padding:9px 16px;border-bottom:1px solid #EDF2F7;display:flex;align-items:flex-start;gap:8px}
.cart-item-num{font-size:10px;color:#A0AEC0;font-weight:800;flex-shrink:0;margin-top:3px;width:20px}
.cart-item-info{flex:1;min-width:0}
.cart-item-titulo{font-weight:600;font-size:12px;line-height:1.4;color:#1A202C}
.cart-item-meta{font-size:11px;color:#718096;margin-top:2px}
.cart-item-del{background:none;border:none;color:#CBD5E0;cursor:pointer;font-size:16px;flex-shrink:0;transition:.1s;padding:0}
.cart-item-del:hover{color:#FC8181}
.cart-empty{padding:48px 16px;text-align:center;color:#A0AEC0;font-size:13px}
.cart-foot{padding:14px 16px;border-top:2px solid #EDF2F7;flex-shrink:0;background:#F7FAFC}
.cart-foot-label{font-size:10px;font-weight:800;text-transform:uppercase;letter-spacing:.06em;color:#718096;margin-bottom:8px}
.cart-assign-row{display:flex;gap:8px;margin-bottom:10px}
.cart-assign-row select{flex:1;padding:8px 10px;border:1.5px solid #CBD5E0;border-radius:6px;font-size:13px;font-family:inherit;background:#fff}
.btn-assign{background:#276749;color:#fff;padding:8px 14px;flex-shrink:0}
.btn-assign:hover{background:#22543D}
.btn-clear-cart{width:100%;padding:7px;background:rgba(252,129,129,.08);border:1px solid #FEB2B2;color:#C53030;font-size:12px;font-weight:600;border-radius:6px;cursor:pointer;transition:.15s}
.btn-clear-cart:hover{background:rgba(252,129,129,.18)}

/* ── ADD MODAL ─────────────────────────────────────────────────── */
.modal-overlay{position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:1000;display:flex;align-items:center;justify-content:center;padding:20px}
.modal{background:#fff;border-radius:12px;width:100%;max-width:660px;max-height:90vh;display:flex;flex-direction:column;box-shadow:0 20px 60px rgba(0,0,0,.3)}
.modal-hdr{background:#1A3A4A;color:#fff;padding:14px 20px;border-radius:12px 12px 0 0;display:flex;justify-content:space-between;align-items:center;flex-shrink:0}
.modal-hdr h3{font-size:14px;font-weight:700}
.modal-close{background:none;border:none;color:#fff;font-size:20px;cursor:pointer;opacity:.7;padding:0 4px}
.modal-close:hover{opacity:1}
.modal-body{padding:20px;overflow-y:auto;flex:1;display:grid;grid-template-columns:1fr 1fr;gap:14px}
.form-field{display:flex;flex-direction:column;gap:5px}
.form-field.full{grid-column:1/-1}
.form-label{font-size:10px;font-weight:800;text-transform:uppercase;letter-spacing:.07em;color:#718096}
.form-field input,.form-field select,.form-field textarea{padding:8px 10px;border:1.5px solid #CBD5E0;border-radius:6px;font-size:13px;font-family:inherit;transition:.15s;background:#fff;color:#1A202C}
.form-field input:focus,.form-field select:focus,.form-field textarea:focus{border-color:#4299E1;outline:none;box-shadow:0 0 0 3px rgba(66,153,225,.12)}
.form-field textarea{min-height:84px;resize:vertical}
.modal-foot{padding:12px 20px;border-top:1px solid #EDF2F7;display:flex;justify-content:flex-end;gap:8px;flex-shrink:0;background:#F7FAFC;border-radius:0 0 12px 12px}
.btn-cancel{background:#EDF2F7;color:#4A5568}.btn-cancel:hover{background:#E2E8F0}
.btn-submit{background:#2B6CB0;color:#fff}.btn-submit:hover{background:#2C5282}
.field-input{width:100%;font-size:13px;color:#2D3748;border:1.5px solid #CBD5E0;border-radius:5px;padding:6px 8px;font-family:inherit;background:#fff}
.btn-novo{background:#276749;color:#fff}.btn-novo:hover{background:#22543D}
.btn-cal{background:rgba(255,255,255,.12);color:#90CDF4;text-decoration:none;display:inline-flex;align-items:center;gap:4px}.btn-cal:hover{background:rgba(255,255,255,.2);color:#fff}
</style>
</head>
<body>
<div class="app">

<div class="header">
  <div>
    <h1>Banco de Temas · @paolapreto</h1>
    <div class="tag">Calendário Editorial 2026 — Feed + Stories</div>
  </div>
  <div class="search-wrap">
    <span class="search-icon">🔍</span>
    <input type="text" id="search" placeholder="Buscar temas, ganchos, orientações..." autocomplete="off">
  </div>
  <span class="counter" id="counter">— temas</span>
  <a href="objetivos.html" class="btn btn-cal">📅 Objetivos</a>
  <button class="btn btn-novo" onclick="openAddModal()">+ Novo tema</button>
  <button class="btn btn-export" onclick="exportHTML()">⬇ Exportar</button>
  <button class="btn btn-reset" onclick="resetData()" title="Descartar todas as edições e restaurar dados originais">↺ Resetar</button>
</div>

<div class="body">
  <aside class="sidebar" id="sidebar"></aside>
  <main class="main">
    <table id="tbl">
      <thead>
        <tr>
          <th class="col-check"><input type="checkbox" id="cbAll" title="Selecionar todos visíveis" onchange="toggleSelectAll(this.checked)" style="accent-color:#90CDF4;width:13px;height:13px;cursor:pointer"></th>
          <th class="col-num">#</th>
          <th class="col-linha th-sort" onclick="sortBy('linha')">Linha <span class="sort-ind" id="si-linha"></span></th>
          <th class="col-subtema th-sort" onclick="sortBy('subtema')">Subtema <span class="sort-ind" id="si-subtema"></span></th>
          <th class="col-titulo th-sort" onclick="sortBy('titulo')">Título <span class="sort-ind" id="si-titulo"></span></th>
          <th class="col-fmt th-sort" onclick="sortBy('formato')">Formato <span class="sort-ind" id="si-formato"></span></th>
          <th class="col-funil th-sort" onclick="sortBy('funil')">Funil <span class="sort-ind" id="si-funil"></span></th>
          <th class="col-serie th-sort" onclick="sortBy('serie')">Série <span class="sort-ind" id="si-serie"></span></th>
          <th class="col-mes th-sort" onclick="sortBy('mes')">Mês <span class="sort-ind" id="si-mes"></span></th>
          <th class="col-exp"></th>
        </tr>
      </thead>
      <tbody id="tbody"></tbody>
    </table>
    <div id="empty" class="empty" style="display:none">
      <div class="icon">🫀</div>
      <p>Nenhum tema encontrado com os filtros ativos.</p>
    </div>
  </main>
</div>
</div>

<!-- ── CART FAB ──────────────────────────────────────────────────── -->
<button class="cart-fab" id="cartFab" onclick="openCart()">
  🛒<span class="cart-fab-count" id="cartFabCount">0</span>
</button>

<!-- ── CART DRAWER ──────────────────────────────────────────────── -->
<div class="drawer-overlay" id="drawerOverlay" onclick="closeCart()"></div>
<div class="cart-drawer" id="cartDrawer">
  <div class="cart-hdr">
    <h3>🛒 Caixinha do mês</h3>
    <button class="cart-close-btn" onclick="closeCart()">✕</button>
  </div>
  <div class="cart-items" id="cartItems"></div>
  <div class="cart-foot">
    <div class="cart-foot-label">Atribuir seleção ao mês:</div>
    <div class="cart-assign-row">
      <select id="cartMesSelect">
        <option value="">— escolha o mês —</option>
        <option>Abril</option><option>Maio</option><option>Junho</option>
        <option>Julho</option><option>Agosto</option><option>Setembro</option>
        <option>Outubro</option><option>Novembro</option><option>Dezembro</option>
        <option>Banco</option>
      </select>
      <button class="btn btn-assign" onclick="assignToMonth()">Aplicar</button>
    </div>
    <button class="btn-clear-cart" onclick="clearSelection()">✕ Limpar seleção</button>
  </div>
</div>

<!-- ── MODAL NOVO TEMA ───────────────────────────────────────────── -->
<div class="modal-overlay" id="modalOverlay" style="display:none" onclick="if(event.target===this)closeAddModal()">
  <div class="modal">
    <div class="modal-hdr">
      <h3>+ Novo tema</h3>
      <button class="modal-close" onclick="closeAddModal()">✕</button>
    </div>
    <div class="modal-body">
      <div class="form-field">
        <label class="form-label">Linha editorial</label>
        <select id="f-linha">
          <option>Medicina do Estilo de Vida</option>
          <option>Conversão</option>
          <option>Causa &amp; Conscientização</option>
          <option>Humanização</option>
        </select>
      </div>
      <div class="form-field">
        <label class="form-label">Subtema</label>
        <input type="text" id="f-subtema" placeholder="Ex: Exercício Físico">
      </div>
      <div class="form-field full">
        <label class="form-label">Título do post</label>
        <input type="text" id="f-titulo" placeholder="Título principal do conteúdo">
      </div>
      <div class="form-field">
        <label class="form-label">Formato</label>
        <select id="f-formato">
          <option>Reels</option><option>Carrossel</option><option>Post único</option>
          <option>Story · Enquete</option><option>Story · Quiz</option>
          <option>Story · Caixinha</option><option>Story · Slider</option>
          <option>Story · Sequência</option>
        </select>
      </div>
      <div class="form-field">
        <label class="form-label">Funil</label>
        <select id="f-funil">
          <option>TOPO</option><option>MEIO</option><option>FUNDO</option>
        </select>
      </div>
      <div class="form-field full">
        <label class="form-label">Objetivo da postagem</label>
        <textarea id="f-objetivo" placeholder="O que esse post pretende alcançar?"></textarea>
      </div>
      <div class="form-field full">
        <label class="form-label">Gancho de abertura</label>
        <textarea id="f-gancho" placeholder="Primeira frase ou frame do conteúdo"></textarea>
      </div>
      <div class="form-field full">
        <label class="form-label">Orientações de produção</label>
        <textarea id="f-orientacoes" placeholder="Roteiro, estrutura de slides, CTA etc."></textarea>
      </div>
      <div class="form-field">
        <label class="form-label">Série</label>
        <select id="f-serie">
          <option>—</option>
          <option>Mito ou Verdade? 🫀</option>
          <option>Pergunte à Dra. Paôla 🩺</option>
        </select>
      </div>
      <div class="form-field">
        <label class="form-label">Mês</label>
        <select id="f-mes">
          <option>Banco</option>
          <option>Abril</option><option>Maio</option><option>Junho</option>
          <option>Julho</option><option>Agosto</option><option>Setembro</option>
          <option>Outubro</option><option>Novembro</option><option>Dezembro</option>
          <option>Janeiro</option><option>Fevereiro</option><option>Março</option>
        </select>
      </div>
    </div>
    <div class="modal-foot">
      <button class="btn btn-cancel" onclick="closeAddModal()">Cancelar</button>
      <button class="btn btn-submit" onclick="submitNewTema()">Adicionar tema</button>
    </div>
  </div>
</div>

<div class="dp-overlay" id="dpOverlay" style="display:none" onclick="closeDropdown()"></div>
<div class="dp-menu" id="dpMenu" style="display:none"></div>
<div class="toast" id="toast">Salvo ✓</div>

<script>
// ── DATA ──────────────────────────────────────────────────────────────────────
window.__TEMAS_DATA__ = __DATA_PLACEHOLDER__;

// ── OPTIONS ──────────────────────────────────────────────────────────────────
const LINHAS   = ["Medicina do Estilo de Vida","Conversão","Causa & Conscientização","Humanização"];
const FORMATOS = ["Reels","Carrossel","Post único","Story · Enquete","Story · Quiz","Story · Caixinha","Story · Slider","Story · Sequência"];
const FUNIS    = ["TOPO","MEIO","FUNDO"];
const SERIES   = ["Mito ou Verdade? 🫀","Pergunte à Dra. Paôla 🩺","—"];
const MESES    = ["Janeiro","Fevereiro","Março","Abril","Maio","Junho",
                  "Julho","Agosto","Setembro","Outubro","Novembro","Dezembro","Banco"];

// ── STATE ────────────────────────────────────────────────────────────────────
let temas = [];
let filters = {linha:[],subtema:[],formato:[],funil:[],serie:[],mes:[]};
let searchQ = '';
let expandedId = null;
let dpTarget = null;
let sortField = null;
let sortDir = 'asc';
let selectedIds = new Set();

// ── INIT ─────────────────────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
  const saved = localStorage.getItem('paola_temas_v2');
  temas = saved ? JSON.parse(saved) : JSON.parse(JSON.stringify(window.__TEMAS_DATA__));
  document.getElementById('search').addEventListener('input', e => {
    searchQ = e.target.value.toLowerCase();
    render();
  });
  buildSidebar();
  render();
});

// ── BADGE CLASSES ────────────────────────────────────────────────────────────
const SUBTEMA_CLASS = {
  "Exercício Físico":"badge-sub-ef","Nutrição & Dieta":"badge-sub-nd",
  "Fatores de Risco":"badge-sub-fr","Sono & Estresse":"badge-sub-se",
  "Exames & Diagnóstico":"badge-sub-ed","Doenças Cardiovasculares":"badge-sub-dc",
  "Apresentação & Posicionamento":"badge-sub-ap","Diferenciais & Especialidade":"badge-sub-de",
  "Onde Atendo & Agenda":"badge-sub-oa","Primeira Consulta":"badge-sub-pc",
  "Q&A & Engajamento":"badge-sub-qa",
};
const LINHA_CLASS = {
  "Medicina do Estilo de Vida":"badge-linha-mev","Conversão":"badge-linha-conv",
  "Causa & Conscientização":"badge-linha-causa","Humanização":"badge-linha-hum",
};
const FMT_CLASS = {
  "Reels":"badge-fmt-reels","Carrossel":"badge-fmt-carrossel","Post único":"badge-fmt-post",
  "Story · Enquete":"badge-fmt-story","Story · Quiz":"badge-fmt-story",
  "Story · Caixinha":"badge-fmt-story","Story · Slider":"badge-fmt-story",
  "Story · Sequência":"badge-fmt-story"
};
const FUNIL_CLASS = {"TOPO":"badge-funil-topo","MEIO":"badge-funil-meio","FUNDO":"badge-funil-fundo"};
const SERIE_CLASS = {"Mito ou Verdade? 🫀":"badge-serie-mv","Pergunte à Dra. Paôla 🩺":"badge-serie-pq","—":"badge-serie-none"};

function badgeLinha(v)   { return `<span class="badge ${LINHA_CLASS[v]||'badge-sub-default'}">${abbr(v)}</span>`; }
function badgeSub(v)     { return `<span class="badge ${SUBTEMA_CLASS[v]||'badge-sub-default'}" title="${v}">${v}</span>`; }
function badgeFmt(v)     { return `<span class="badge ${FMT_CLASS[v]||'badge-sub-default'}">${v}</span>`; }
function badgeFunil(v)   { return `<span class="badge ${FUNIL_CLASS[v]||'badge-sub-default'}">${v}</span>`; }
function badgeSerie(v)   { return `<span class="badge ${SERIE_CLASS[v]||'badge-serie-none'}">${v==='—'?'Sem série':v}</span>`; }
function badgeMes(v)     { const c = v==='Banco'?'badge-mes-banco':'badge-mes'; return `<span class="badge ${c}">${v}</span>`; }
function abbr(linha) {
  const m = {"Medicina do Estilo de Vida":"MEV","Conversão":"Conv","Causa & Conscientização":"Causa","Humanização":"Hum"};
  return m[linha]||linha;
}

// ── SORT ─────────────────────────────────────────────────────────────────────
function sortBy(field) {
  if (sortField === field) { sortDir = sortDir === 'asc' ? 'desc' : 'asc'; }
  else { sortField = field; sortDir = 'asc'; }
  document.querySelectorAll('.sort-ind').forEach(el => el.textContent = '');
  const ind = document.getElementById('si-' + field);
  if (ind) ind.textContent = sortDir === 'asc' ? '▲' : '▼';
  render();
}

// ── FILTER + SORT ─────────────────────────────────────────────────────────────
function getFiltered() {
  let result = temas.filter(t => {
    if (filters.linha.length   && !filters.linha.includes(t.linha))     return false;
    if (filters.subtema.length && !filters.subtema.includes(t.subtema)) return false;
    if (filters.formato.length && !filters.formato.includes(t.formato)) return false;
    if (filters.funil.length   && !filters.funil.includes(t.funil))     return false;
    if (filters.serie.length   && !filters.serie.includes(t.serie))     return false;
    if (filters.mes.length     && !filters.mes.includes(t.mes))         return false;
    if (searchQ) {
      const s = searchQ;
      return t.titulo.toLowerCase().includes(s) ||
             t.objetivo.toLowerCase().includes(s) ||
             t.gancho.toLowerCase().includes(s) ||
             t.orientacoes.toLowerCase().includes(s) ||
             t.subtema.toLowerCase().includes(s);
    }
    return true;
  });
  if (sortField) {
    result = [...result].sort((a, b) => {
      const va = (a[sortField]||'').toLowerCase();
      const vb = (b[sortField]||'').toLowerCase();
      return sortDir === 'asc' ? va.localeCompare(vb,'pt') : vb.localeCompare(va,'pt');
    });
  }
  return result;
}

// ── SELECTION ─────────────────────────────────────────────────────────────────
function toggleSelectAll(checked) {
  const filtered = getFiltered();
  filtered.forEach(t => { if (checked) selectedIds.add(t.id); else selectedIds.delete(t.id); });
  updateCartFab();
  render();
}

function toggleSelect(id, checked, e) {
  e.stopPropagation();
  if (checked) selectedIds.add(id); else selectedIds.delete(id);
  updateCartFab();
  const row = document.querySelector(`tr[data-id="${id}"]`);
  if (row) row.classList.toggle('selected-row', checked);
  const cbAll = document.getElementById('cbAll');
  if (cbAll) {
    const filtered = getFiltered();
    const selInView = filtered.filter(t => selectedIds.has(t.id)).length;
    cbAll.checked = filtered.length > 0 && selInView === filtered.length;
    cbAll.indeterminate = selInView > 0 && selInView < filtered.length;
  }
}

function updateCartFab() {
  const fab = document.getElementById('cartFab');
  const cnt = document.getElementById('cartFabCount');
  const n = selectedIds.size;
  fab.style.display = n > 0 ? 'block' : 'none';
  cnt.textContent = n;
}

// ── CART DRAWER ───────────────────────────────────────────────────────────────
function openCart() {
  renderCart();
  document.getElementById('drawerOverlay').style.display = '';
  document.getElementById('cartDrawer').classList.add('open');
}

function closeCart() {
  document.getElementById('drawerOverlay').style.display = 'none';
  document.getElementById('cartDrawer').classList.remove('open');
}

function renderCart() {
  const container = document.getElementById('cartItems');
  if (selectedIds.size === 0) {
    container.innerHTML = '<div class="cart-empty">Nenhum tema selecionado.<br>Marque temas na tabela para adicioná-los aqui.</div>';
    return;
  }
  const selected = temas.filter(t => selectedIds.has(t.id));
  container.innerHTML = selected.map((t, i) => `
    <div class="cart-item">
      <div class="cart-item-num">${i+1}</div>
      <div class="cart-item-info">
        <div class="cart-item-titulo" title="${escHtml(t.titulo)}">${escHtml(t.titulo)}</div>
        <div class="cart-item-meta">${abbr(t.linha)} · ${t.formato} · <strong>${t.mes}</strong></div>
      </div>
      <button class="cart-item-del" onclick="removeFromCart(${t.id})" title="Remover da seleção">✕</button>
    </div>
  `).join('');
}

function removeFromCart(id) {
  selectedIds.delete(id);
  updateCartFab();
  renderCart();
  const row = document.querySelector(`tr[data-id="${id}"]`);
  if (row) row.classList.remove('selected-row');
  const cb = row ? row.querySelector('input[type=checkbox]') : null;
  if (cb) cb.checked = false;
}

function assignToMonth() {
  const mes = document.getElementById('cartMesSelect').value;
  if (!mes) { alert('Escolha um mês antes de aplicar.'); return; }
  const count = selectedIds.size;
  if (!count) return;
  if (!confirm(`Atribuir ${count} tema(s) ao mês "${mes}"?\nIsso substitui o mês atual de cada tema selecionado.`)) return;
  selectedIds.forEach(id => {
    const t = temas.find(x => x.id === id);
    if (t) t.mes = mes;
  });
  save();
  clearSelection();
}

function clearSelection() {
  selectedIds.clear();
  updateCartFab();
  closeCart();
  render();
}

// ── RENDER TABLE ─────────────────────────────────────────────────────────────
function render() {
  const filtered = getFiltered();
  const total = temas.length;
  document.getElementById('counter').textContent =
    filtered.length === total ? `${total} temas` : `${filtered.length} de ${total} temas`;

  const cbAll = document.getElementById('cbAll');
  if (cbAll) {
    const selInView = filtered.filter(t => selectedIds.has(t.id)).length;
    cbAll.checked = filtered.length > 0 && selInView === filtered.length;
    cbAll.indeterminate = selInView > 0 && selInView < filtered.length;
  }

  const tbody = document.getElementById('tbody');
  const empty = document.getElementById('empty');

  if (filtered.length === 0) {
    tbody.innerHTML = '';
    empty.style.display = '';
    return;
  }
  empty.style.display = 'none';

  let html = '';
  filtered.forEach((t, idx) => {
    const isExp = expandedId === t.id;
    const isSel = selectedIds.has(t.id);
    let cls = 'summary';
    if (isExp) cls += ' expanded-row';
    if (isSel) cls += ' selected-row';

    html += `<tr class="${cls}" data-id="${t.id}" onclick="toggleExpand(${t.id})">
      <td onclick="event.stopPropagation()" style="text-align:center;width:36px">
        <input type="checkbox" ${isSel?'checked':''} onchange="toggleSelect(${t.id},this.checked,event)" style="accent-color:#744210;width:13px;height:13px;cursor:pointer">
      </td>
      <td class="td-num">${idx + 1}</td>
      <td>${badgeLinha(t.linha)}</td>
      <td>${badgeSub(t.subtema)}</td>
      <td class="td-titulo">${escHtml(t.titulo)}</td>
      <td onclick="event.stopPropagation();openDrop(${t.id},'formato',this)" style="cursor:pointer">${badgeFmt(t.formato)}</td>
      <td onclick="event.stopPropagation();openDrop(${t.id},'funil',this)" style="cursor:pointer">${badgeFunil(t.funil)}</td>
      <td onclick="event.stopPropagation();openDrop(${t.id},'serie',this)" style="cursor:pointer">${badgeSerie(t.serie)}</td>
      <td onclick="event.stopPropagation();openDrop(${t.id},'mes',this)" style="cursor:pointer">${badgeMes(t.mes)}</td>
      <td class="expand-btn">${isExp?'▲':'▼'}</td>
    </tr>`;

    if (isExp) {
      html += `<tr class="detail show" id="detail-${t.id}">
        <td colspan="10">
          <div class="detail-panel">
            <div class="field-block" style="margin-bottom:14px">
              <div class="field-label">Título</div>
              <div class="field-content" onclick="startEditInp(event,${t.id},'titulo')">${escHtml(t.titulo)}</div>
              <input class="field-input" id="inp-${t.id}-titulo" style="display:none" value="${escHtml(t.titulo)}"
                onblur="saveFieldInp(${t.id},'titulo')"
                onkeydown="if(event.key==='Enter'){this.blur()}if(event.key==='Escape'){cancelEditInp(${t.id},'titulo')}">
            </div>
            <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:10px;margin-bottom:14px">
              <div>
                <div class="field-label">Linha editorial</div>
                <select class="field-input" style="border-color:#CBD5E0;padding:6px 8px;font-size:12px" onchange="quickField(${t.id},'linha',this.value)">
                  ${LINHAS.map(l=>`<option${l===t.linha?' selected':''}>${l}</option>`).join('')}
                </select>
              </div>
              <div>
                <div class="field-label">Subtema</div>
                <div class="field-content" onclick="startEditInp(event,${t.id},'subtema')" style="font-size:12px">${escHtml(t.subtema)}</div>
                <input class="field-input" id="inp-${t.id}-subtema" style="display:none;font-size:12px" value="${escHtml(t.subtema)}"
                  onblur="saveFieldInp(${t.id},'subtema')"
                  onkeydown="if(event.key==='Enter'){this.blur()}if(event.key==='Escape'){cancelEditInp(${t.id},'subtema')}">
              </div>
              <div>
                <div class="field-label">Funil</div>
                <select class="field-input" style="border-color:#CBD5E0;padding:6px 8px;font-size:12px" onchange="quickField(${t.id},'funil',this.value)">
                  ${FUNIS.map(f=>`<option${f===t.funil?' selected':''}>${f}</option>`).join('')}
                </select>
              </div>
            </div>
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px">
              <div>
                ${textField(t,'objetivo','Objetivo da postagem')}
                ${textField(t,'gancho','Gancho de abertura')}
              </div>
              <div>
                ${textField(t,'orientacoes','Orientações de produção')}
              </div>
            </div>
          </div>
        </td>
      </tr>`;
    }
  });

  tbody.innerHTML = html;
  updateSidebarCounts();
}

function textField(t, field, label) {
  return `<div class="field-block">
    <div class="field-label">${label}</div>
    <div class="field-content" onclick="startEdit(event,${t.id},'${field}')">${escHtml(t[field])}</div>
    <textarea class="field-textarea" id="ta-${t.id}-${field}" style="display:none"
      onblur="saveField(${t.id},'${field}')"
      onkeydown="if((e=event).key==='Escape'){cancelEdit(${t.id},'${field}')}"
    >${escHtml(t[field])}</textarea>
    <div class="field-hint" id="hint-${t.id}-${field}" style="display:none">Clique fora ou Esc para cancelar</div>
  </div>`;
}

// ── EXPAND ───────────────────────────────────────────────────────────────────
function toggleExpand(id) {
  expandedId = expandedId === id ? null : id;
  render();
}

// ── INLINE EDIT — TEXTAREA ────────────────────────────────────────────────────
function startEdit(e, id, field) {
  e.stopPropagation();
  const content = e.currentTarget;
  const ta = document.getElementById(`ta-${id}-${field}`);
  const hint = document.getElementById(`hint-${id}-${field}`);
  content.classList.add('editing');
  if (ta) { ta.style.display=''; if (hint) hint.style.display=''; ta.focus(); ta.select(); }
}

function saveField(id, field) {
  const ta = document.getElementById(`ta-${id}-${field}`);
  if (!ta) return;
  const t = temas.find(x => x.id === id);
  if (t) { t[field] = ta.value; save(); }
  const content = ta.previousElementSibling;
  if (content) { content.textContent = ta.value; content.classList.remove('editing'); }
  ta.style.display = 'none';
  const hint = document.getElementById(`hint-${id}-${field}`);
  if (hint) hint.style.display = 'none';
}

function cancelEdit(id, field) {
  const t = temas.find(x => x.id === id);
  const ta = document.getElementById(`ta-${id}-${field}`);
  if (t && ta) { ta.value = t[field]; ta.blur(); }
}

// ── INLINE EDIT — INPUT ───────────────────────────────────────────────────────
function startEditInp(e, id, field) {
  e.stopPropagation();
  const content = e.currentTarget;
  const inp = document.getElementById(`inp-${id}-${field}`);
  content.classList.add('editing');
  if (inp) { inp.style.display=''; inp.focus(); inp.select(); }
}

function saveFieldInp(id, field) {
  const inp = document.getElementById(`inp-${id}-${field}`);
  if (!inp) return;
  const t = temas.find(x => x.id === id);
  if (t) { t[field] = inp.value; save(); }
  const content = inp.previousElementSibling;
  if (content && content.classList.contains('field-content')) {
    content.textContent = inp.value; content.classList.remove('editing');
  }
  inp.style.display = 'none';
  if (field === 'titulo') {
    // update summary row title without full re-render
    const row = document.querySelector(`tr[data-id="${id}"] .td-titulo`);
    if (row) row.textContent = inp.value;
  }
}

function cancelEditInp(id, field) {
  const t = temas.find(x => x.id === id);
  const inp = document.getElementById(`inp-${id}-${field}`);
  if (t && inp) { inp.value = t[field]; inp.blur(); }
}

// ── QUICK FIELD (inline select) ───────────────────────────────────────────────
function quickField(id, field, value) {
  const t = temas.find(x => x.id === id);
  if (t) { t[field] = value; save(); }
  if (field === 'linha') render(); // refresh badge in summary row
}

// ── DROPDOWN ─────────────────────────────────────────────────────────────────
const DROP_OPTIONS = { formato:FORMATOS, funil:FUNIS, serie:SERIES, mes:MESES };

function openDrop(id, field, el) {
  const opts = DROP_OPTIONS[field];
  if (!opts) return;
  const t = temas.find(x => x.id === id);
  if (!t) return;
  dpTarget = {id, field};
  const rect = el.getBoundingClientRect();
  const menu = document.getElementById('dpMenu');
  menu.innerHTML = opts.map(o =>
    `<div class="dp-item${t[field]===o?' active':''}" onclick="selectDrop('${escAttr(o)}')">${o}</div>`
  ).join('');
  menu.style.display = '';
  document.getElementById('dpOverlay').style.display = '';
  let top = rect.bottom + 4, left = rect.left;
  if (top + 220 > window.innerHeight) top = rect.top - 220;
  if (left + 180 > window.innerWidth) left = window.innerWidth - 190;
  menu.style.top = top + 'px';
  menu.style.left = left + 'px';
}

function selectDrop(value) {
  if (!dpTarget) return;
  const t = temas.find(x => x.id === dpTarget.id);
  if (t) { t[dpTarget.field] = value; save(); }
  closeDropdown();
  render();
}

function closeDropdown() {
  document.getElementById('dpMenu').style.display = 'none';
  document.getElementById('dpOverlay').style.display = 'none';
  dpTarget = null;
}

// ── SIDEBAR ───────────────────────────────────────────────────────────────────
function buildSidebar() {
  const allSubtemas = [...new Set(temas.map(t => t.subtema))].sort();
  const sections = [
    {key:'linha',   label:'Linha Editorial', opts:LINHAS},
    {key:'subtema', label:'Subtema',         opts:allSubtemas},
    {key:'formato', label:'Formato',         opts:FORMATOS},
    {key:'funil',   label:'Funil',           opts:FUNIS},
    {key:'serie',   label:'Série',           opts:SERIES},
    {key:'mes',     label:'Mês',             opts:MESES},
  ];
  let html = '<button class="sidebar-clear" onclick="clearFilters()">Limpar todos os filtros</button>';
  sections.forEach(sec => {
    html += `<div class="filter-group">
      <div class="filter-title" onclick="toggleSection(this)">
        ${sec.label} <span class="arrow">▾</span>
      </div>
      <div class="filter-items" data-key="${sec.key}">`;
    sec.opts.forEach(opt => {
      const cnt = temas.filter(t => t[sec.key] === opt).length;
      if (cnt === 0) return;
      const eid = `cb-${sec.key}-${opt.replace(/[^a-z0-9]/gi,'_')}`;
      html += `<div class="filter-item">
        <input type="checkbox" id="${eid}" value="${escAttr(opt)}"
          onchange="toggleFilter('${sec.key}','${escAttr(opt)}',this.checked)">
        <label for="${eid}" title="${opt}">${opt}</label>
        <span class="count" id="cnt-${sec.key}-${opt.replace(/[^a-z0-9]/gi,'_')}">${cnt}</span>
      </div>`;
    });
    html += '</div></div>';
  });
  document.getElementById('sidebar').innerHTML = html;
}

function updateSidebarCounts() {
  const filtered = getFiltered();
  const allSubtemas = [...new Set(temas.map(t => t.subtema))];
  const sections = [
    {key:'linha',opts:LINHAS},{key:'subtema',opts:allSubtemas},
    {key:'formato',opts:FORMATOS},{key:'funil',opts:FUNIS},
    {key:'serie',opts:SERIES},{key:'mes',opts:MESES},
  ];
  sections.forEach(sec => {
    sec.opts.forEach(opt => {
      const el = document.getElementById(`cnt-${sec.key}-${opt.replace(/[^a-z0-9]/gi,'_')}`);
      if (!el) return;
      el.textContent = filtered.filter(t => t[sec.key] === opt).length;
    });
  });
}

function toggleFilter(key, value, checked) {
  if (checked) { if (!filters[key].includes(value)) filters[key].push(value); }
  else { filters[key] = filters[key].filter(v => v !== value); }
  render();
}

function clearFilters() {
  filters = {linha:[],subtema:[],formato:[],funil:[],serie:[],mes:[]};
  document.querySelectorAll('.filter-item input[type=checkbox]').forEach(cb => cb.checked = false);
  searchQ = '';
  document.getElementById('search').value = '';
  render();
}

function toggleSection(titleEl) {
  titleEl.classList.toggle('collapsed');
  titleEl.nextElementSibling.classList.toggle('hidden');
}

// ── ADD TEMA MODAL ───────────────────────────────────────────────────────────
function openAddModal() {
  document.getElementById('modalOverlay').style.display = 'flex';
  setTimeout(() => document.getElementById('f-titulo').focus(), 50);
}

function closeAddModal() {
  document.getElementById('modalOverlay').style.display = 'none';
  ['f-subtema','f-titulo','f-objetivo','f-gancho','f-orientacoes'].forEach(id => {
    const el = document.getElementById(id); if (el) el.value = '';
  });
  document.getElementById('f-linha').selectedIndex = 0;
  document.getElementById('f-formato').selectedIndex = 0;
  document.getElementById('f-funil').selectedIndex = 0;
  document.getElementById('f-serie').selectedIndex = 0;
  document.getElementById('f-mes').selectedIndex = 0;
}

function submitNewTema() {
  const titulo = document.getElementById('f-titulo').value.trim();
  if (!titulo) { alert('O título é obrigatório.'); document.getElementById('f-titulo').focus(); return; }
  const newId = temas.length > 0 ? Math.max(...temas.map(t => t.id)) + 1 : 0;
  const novo = {
    id: newId,
    linha:       document.getElementById('f-linha').value,
    subtema:     document.getElementById('f-subtema').value.trim() || '—',
    titulo,
    formato:     document.getElementById('f-formato').value,
    funil:       document.getElementById('f-funil').value,
    objetivo:    document.getElementById('f-objetivo').value.trim(),
    gancho:      document.getElementById('f-gancho').value.trim(),
    orientacoes: document.getElementById('f-orientacoes').value.trim(),
    serie:       document.getElementById('f-serie').value,
    mes:         document.getElementById('f-mes').value,
  };
  temas.push(novo);
  save();
  buildSidebar();
  closeAddModal();
  expandedId = newId;
  sortField = null;
  document.querySelectorAll('.sort-ind').forEach(el => el.textContent = '');
  render();
}

// ── PERSISTENCE ───────────────────────────────────────────────────────────────
let toastTimer;
function save() {
  localStorage.setItem('paola_temas_v2', JSON.stringify(temas));
  const toast = document.getElementById('toast');
  toast.classList.add('show');
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => toast.classList.remove('show'), 1600);
}

function resetData() {
  if (!confirm('Descartar TODAS as edições e restaurar os dados originais?')) return;
  localStorage.removeItem('paola_temas_v2');
  temas = JSON.parse(JSON.stringify(window.__TEMAS_DATA__));
  expandedId = null;
  sortField = null;
  selectedIds.clear();
  updateCartFab();
  buildSidebar();
  clearFilters();
}

// ── EXPORT ───────────────────────────────────────────────────────────────────
function exportHTML() {
  const src = document.documentElement.outerHTML;
  const dataStr = JSON.stringify(temas, null, 2);
  const updated = src.replace(
    /window\.__TEMAS_DATA__ = \[[\s\S]*?\];/,
    `window.__TEMAS_DATA__ = ${dataStr};`
  );
  const blob = new Blob([updated], {type:'text/html;charset=utf-8'});
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = 'banco_temas_editado.html';
  a.click();
  setTimeout(() => URL.revokeObjectURL(a.href), 5000);
}

// ── UTILS ────────────────────────────────────────────────────────────────────
function escHtml(s) {
  return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}
function escAttr(s) {
  return String(s).replace(/'/g,"\\'").replace(/"/g,'&quot;');
}
</script>
</body>
</html>"""

# Fix the regex in the export function — needs escaped backslashes in the HTML
HTML = HTML.replace(
    r"window\.__TEMAS_DATA__ = \[[\s\S]*?\];",
    r"window\.__TEMAS_DATA__ = \[[\s\S]*?\];"
)

# Embed data
html_out = HTML.replace("__DATA_PLACEHOLDER__", data_json)

with open(OUT, "w", encoding="utf-8") as f:
    f.write(html_out)

print(f"Gerado: {OUT}")
print(f"Total de temas: {len(all_topics)} (MEV: {len(MEV)}, Conversão: {len(CONV)})")
