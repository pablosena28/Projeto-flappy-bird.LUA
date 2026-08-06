# Projeto Flappy Bird em Lua

Uma releitura educacional de **Flappy Bird**, desenvolvida em Lua com o
framework [LÖVE2D](https://love2d.org/). O projeto consolida os conceitos da
aula de Flappy Bird do Curso de Extensão — Lua + LÖVE2D e os apresenta em uma
estrutura organizada para portfólio.

## Destaques

- física consistente em diferentes taxas de quadros;
- máquina de estados para título, contagem, partida e resultado;
- canos gerados proceduralmente com variação controlada;
- dificuldade progressiva por velocidade e tamanho da passagem;
- colisão AABB com margens mais justas;
- recorde salvo localmente;
- pausa e suporte a teclado e mouse;
- resolução virtual com janela redimensionável.

## Controles

| Ação | Controle |
|---|---|
| Iniciar/reiniciar | `Enter`, `Espaço` ou clique esquerdo |
| Voar | `Espaço`, `↑` ou clique esquerdo |
| Pausar/continuar | `P` |
| Sair | `Esc` |

## Como executar

1. Instale o [LÖVE2D 11.x](https://love2d.org/).
2. Clone este repositório.
3. Execute a pasta do projeto com o LÖVE2D:

```bash
love .
```

No Windows, também é possível arrastar a pasta do projeto sobre o executável
do LÖVE2D.

## Organização

```text
.
├── assets/             # sprites, fontes e efeitos sonoros
├── docs/               # registro do processo de aprendizado
├── lib/                # bibliotecas auxiliares
├── src/
│   ├── states/         # estados do fluxo do jogo
│   ├── Bird.lua        # física, entrada e colisão do jogador
│   ├── Pipe.lua        # representação de um cano
│   ├── PipePair.lua    # par de obstáculos e movimento
│   └── StateMachine.lua
├── conf.lua            # configuração do LÖVE2D
└── main.lua            # carregamento e ciclo principal
```

## Decisões técnicas

A lógica utiliza uma resolução virtual de `512 × 288`, escalada pela biblioteca
`push`, para preservar o visual pixel art. O estado de partida calcula a
dificuldade a partir da pontuação e impõe limites para não gerar passagens
impossíveis. O recorde é armazenado pelo `love.filesystem`, no diretório de
dados da aplicação.

O detalhamento do estudo está em
[`docs/processo-de-aprendizado.md`](docs/processo-de-aprendizado.md).

## Créditos

Projeto criado por **Pablo Sena** como exercício de estudo e portfólio, com
base no [Curso de Extensão — Lua + LÖVE2D](https://github.com/ConwayUSP/CursoExtensaoGameDev)
e nas anotações da aula. Consulte também os
[`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md).

## Licença

O código autoral deste repositório está sob a licença [MIT](LICENSE). Recursos
de terceiros seguem os avisos e condições descritos nos créditos.
