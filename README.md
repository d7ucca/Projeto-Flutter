# GymD10 

## Descrição

Este projeto foi desenvolvido em Flutter com o objetivo de auxiliar alunos de academia no acompanhamento de seus treinos semanais.

O sistema permite autenticação de usuários, visualização de treinos organizados por dia da semana e armazenamento local dos exercícios utilizando SQLite.

## Funcionalidades

* Login de usuários
* Cadastro de usuários
* Visualização dos treinos por dia da semana
* Armazenamento local utilizando SQLite
* Modo de demonstração para testes

## Como Executar o Projeto

### Pré-requisitos

* Flutter SDK
* Android Studio
* Android SDK configurado

### Executando pelo código-fonte

1. Clone o repositório:

```bash
git clone <url-do-repositorio>
```

2. Acesse a pasta do projeto:

```bash
cd Projeto-Flutter
```

3. Instale as dependências:

```bash
flutter pub get
```

4. Conecte um dispositivo Android ou inicie um emulador.

5. Execute o projeto:

```bash
flutter run
```

### Executando pelo APK

Também é possível instalar diretamente o arquivo APK gerado:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Basta transferir o APK para um dispositivo Android e realizar a instalação.

## Observação Importante

O sistema utiliza uma API externa fornecida pelo professor para autenticação de usuários.

Caso a API esteja indisponível ou fora do ar durante os testes, basta informar qualquer usuário e qualquer senha na tela de login. O aplicativo entrará automaticamente em modo de demonstração utilizando um usuário de teste previamente configurado, permitindo a navegação e visualização dos treinos normalmente.

## Tecnologias Utilizadas

* Flutter
* Dart
* SQLite (sqflite)
* Android Studio
* Git/GitHub

## Objetivo do Projeto

Demonstrar conceitos de desenvolvimento mobile utilizando Flutter, autenticação de usuários, persistência de dados local, navegação entre telas e organização de treinos por usuário e dia da semana.
