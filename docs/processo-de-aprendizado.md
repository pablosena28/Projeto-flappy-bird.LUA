# Processo de aprendizado

## Origem

O projeto nasceu das anotações feitas durante a aula de Flappy Bird do Curso
de Extensão — Lua + LÖVE2D. O passo a passo introduziu o carregamento de
sprites, a gravidade do pássaro, a geração de pares de canos, colisões AABB,
pontuação e uma máquina de estados para organizar o fluxo da partida.

## Como a aula foi transformada em projeto de portfólio

Além de reproduzir a mecânica ensinada, a implementação foi reorganizada para
evidenciar decisões comuns em projetos reais:

1. **Máquina de estados:** título, contagem regressiva, partida e resultado
   possuem responsabilidades independentes.
2. **Contexto compartilhado:** imagens, fontes, sons, entrada e recorde são
   carregados uma vez e injetados nos estados.
3. **Física baseada em tempo:** gravidade e deslocamento usam `dt`, mantendo o
   comportamento consistente em diferentes taxas de quadros.
4. **Dificuldade progressiva:** a velocidade cresce e o espaço entre canos
   diminui conforme a pontuação aumenta, respeitando limites de jogabilidade.
5. **Experiência do jogador:** colisão com margens, pausa, suporte a mouse,
   recorde persistente e reinício rápido.
6. **Manutenção:** constantes ficam centralizadas e comentários registram o
   motivo de decisões menos óbvias.

## Conceitos praticados

- Lua e orientação a objetos por tabelas/metatables;
- callbacks e ciclo de vida do LÖVE2D;
- renderização em resolução virtual;
- movimento, aceleração e rotação de sprites;
- colisão AABB;
- geração procedural controlada;
- áudio, entrada e persistência local;
- estados de jogo e separação de responsabilidades.

## Próximas evoluções possíveis

- animação com spritesheet para o pássaro;
- menu de acessibilidade e controle de volume;
- testes automatizados para regras que não dependem do LÖVE2D;
- empacotamento para Windows, Linux e Web.
