# AppConsultaCEP

Este é um aplicativo Flutter desenvolvido como projeto acadêmico para a disciplina de **Desenvolvimento de Aplicativos Mobile**. O app permite consultar informações de um endereço a partir de um CEP informado pelo usuário, utilizando a API pública do [ViaCEP](https://viacep.com.br/).

---

## 🚀 Funcionalidades

- ✅ Consulta de endereço por CEP
- ✅ Integração com a API ViaCEP
- ✅ Interface limpa e intuitiva
- ✅ Mensagens de erro amigáveis
- ✅ Estrutura de código organizada

---

🛠️ Tecnologias Utilizadas:

- Flutter (Dart)

- API REST (ViaCEP)

- http (requisições Web)

- dart:convert (para decodificação de JSON)

📸 Captura de Tela:

Base do projeto:

![Image](https://github.com/user-attachments/assets/a5f86c3c-b665-452f-ade7-f1f488b59125)

Tela final:



---

## 🧱 Estrutura de Arquivos

```bash
lib/
├── models/
│   └── resultado_cep.dart         # Modelo de dados do resultado da API
│
├── services/
│   └── servico_via_cep.dart       # Serviço para consultar a API ViaCEP
│
└── main.dart                      # Interface principal e lógica de busca

