# 🧑‍🍳 AI Chef

Um assistente de culinária inteligente em Flutter que gera receitas originais usando a IA do Google Gemini com base nos ingredientes que você tem em casa.

## ✨ Funcionalidades

- **Geração por IA:** Crie receitas únicas a partir de uma lista de ingredientes.
- **Informações Nutricionais:** Obtenha uma estimativa de calorias para cada prato.
- **Biblioteca Pessoal:** Salve suas receitas favoritas em um banco de dados local.
- **Edição Completa:** Altere ingredientes e passos das receitas salvas para ajustá-las ao seu gosto.

## 🏛️ Arquitetura

O projeto utiliza a arquitetura **MVVM (Model-View-ViewModel)** com princípios da **Clean Architecture**.

- **`pages` (View):** Telas da UI, responsáveis apenas por exibir dados.
- **`view_models` (ViewModel):** Gerencia o estado e a lógica de apresentação das telas.
- **`models` (Model):** Define as entidades de dados (ex: Receita).
- **`services` (Repository):** Abstrai a lógica de acesso aos dados.
- **`datasources` (DataSource):** Implementação concreta do acesso a dados (API Remota e DB Local).

**Fluxo de Dados:**
`View` → `ViewModel` → `Service (Interface)` → `Service (Impl)` → `DataSource`

## 🚀 Como Executar

Siga os passos abaixo para configurar e executar o projeto localmente.

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado e configurado.
- Um emulador Android ou iOS, ou um dispositivo físico.

### 1. Clone o Repositório

```bash
git clone [URL_DO_SEU_REPOSITORIO]
cd chef_ia
```

### 2. Configure a API Key do Gemini

Para que o app funcione, você precisa de uma API Key do Google Gemini.

1.  Vá para o **[Google AI Studio](https://aistudio.google.com/)** e crie sua chave de API gratuita.
2.  Copie a chave gerada.
3.  Abra o arquivo `lib/data/datasources/gemini_remote_datasource.dart`.
4.  Cole sua chave na variável `_apiKey`:

    ```dart
    // lib/data/datasources/gemini_remote_data_source.dart

    class GeminiRemoteDataSourceImpl implements GeminiRemoteDataSource {
      // ...
      // IMPORTANTE: Substitua pela sua API Key do Google AI Studio
      final String _apiKey = "GEMINI_API_KEY";
      // ...
    }
    ```

    > **Aviso:** Nunca envie sua chave de API para repositórios públicos.

### 3. Instale as Dependências

```bash
flutter pub get
```

### 4. Execute o Aplicativo

```bash
flutter run
```

## 🧪 Testes

Para rodar os testes unitários e garantir que tudo está funcionando como esperado, execute:

```bash
flutter test
```
