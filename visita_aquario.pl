% Definindo os atributos de cada pessoa
mochila(amarela).
mochila(azul).
mochila(branca).
mochila(verde).
mochila(vermelha).

nome(cristina).
nome(gisele).
nome(milene).
nome(regina).
nome(sabrina).

sobrenome(andrade).
sobrenome(dias).
sobrenome(lima).
sobrenome(santos).
sobrenome(rocha).

suco(caju).
suco(laranja).
suco(maca).
suco(maracuja).
suco(uva).

signo(aries).
signo(cancer).
signo(escorpiao).
signo(peixes).
signo(virgem).

animal(arraia).
animal(lobo_marinho).
animal(peixe_boi).
animal(piranha).
animal(tubarao).

% Regras auxiliares

% X está ao lado de Y
aoLado(X, Y, Lista) :- nextto(X, Y, Lista); nextto(Y, X, Lista).

% X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X, Y, Lista) :- nth0(IndexX, Lista, X), nth0(IndexY, Lista, Y), IndexX < IndexY.

% X está no canto se ele é o primeiro ou o último da lista
noCanto(X, Lista) :- last(Lista, X).
noCanto(X, [X|_]).

% Todos diferentes (para garantir que cada atributo seja único)
todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

% Solução do problema
solucao(ListaSolucao) :-
    ListaSolucao = [
        amiga(Mochila1, Nome1, Sobrenome1, Suco1, Signo1, Animal1),
        amiga(Mochila2, Nome2, Sobrenome2, Suco2, Signo2, Animal2),
        amiga(Mochila3, Nome3, Sobrenome3, Suco3, Signo3, Animal3),
        amiga(Mochila4, Nome4, Sobrenome4, Suco4, Signo4, Animal4),
        amiga(Mochila5, Nome5, Sobrenome5, Suco5, Signo5, Animal5)
    ],

    % Restrições baseadas nas dicas fornecidas:
    
    % A menina da mochila Branca tem sobrenome Andrade.
    member(amiga(branca, _, andrade, _, _, _), ListaSolucao),

    % A garota da mochila Amarela está em algum lugar entre a da mochila Verde e a Sabrina, nessa ordem.
    aEsquerda(amiga(verde, _, _, _, _, _), amiga(amarela, _, _, _, _, _), ListaSolucao),
    aEsquerda(amiga(amarela, _, _, _, _, _), amiga(_, sabrina, _, _, _, _), ListaSolucao),

    % A menina de Câncer está exatamente à direita da que quer ver o Peixe-boi.
    nextto(amiga(_, _, _, _, _, peixe_boi), amiga(_, _, _, _, cancer, _), ListaSolucao),

    % Milene e Sabrina estão lado a lado.
    aoLado(amiga(_, milene, _, _, _, _), amiga(_, sabrina, _, _, _, _), ListaSolucao),

    % A garota que quer ver a Piranha está em uma das pontas.
    noCanto(amiga(_, _, _, _, _, piranha), ListaSolucao),

    % Milene é do signo de Virgem.
    member(amiga(_, milene, _, _, virgem, _), ListaSolucao),

    % A garota do signo de Áries está ao lado da que quer ver o Peixe-boi.
    aoLado(amiga(_, _, _, _, aries, _), amiga(_, _, _, _, _, peixe_boi), ListaSolucao),

    % Sabrina está em uma das pontas.
    noCanto(amiga(_, sabrina, _, _, _, _), ListaSolucao),

    % Na terceira posição está a menina que gosta de suco de Maçã.
    nth0(2, ListaSolucao, amiga(_, _, _, maca, _, _)),

    % A menina da mochila Amarela está em algum lugar entre a Regina e a garota de sobrenome Andrade, nessa ordem.
    aEsquerda(amiga(_, regina, _, _, _, _), amiga(amarela, _, _, _, _, _), ListaSolucao),
    aEsquerda(amiga(amarela, _, _, _, _, _), amiga(_, _, andrade, _, _, _), ListaSolucao),

    % A garota que quer ver o Tubarão está exatamente à direita da garota da mochila Amarela.
    nextto(amiga(amarela, _, _, _, _, _), amiga(_, _, _, _, _, tubarao), ListaSolucao),

    % A menina de sobrenome Lima está ao lado da garota que gosta de suco de Uva.
    aoLado(amiga(_, _, lima, _, _, _), amiga(_, _, _, uva, _, _), ListaSolucao),

    % Na segunda posição está a menina que nasceu em outubro.
    nth0(1, ListaSolucao, amiga(_, _, _, _, escorpiao, _)),

    % A garota do sobrenome Santos deseja ver o Peixe-boi.
    member(amiga(_, _, santos, _, _, peixe_boi), ListaSolucao),

    % Em uma das pontas está a menina do signo de Peixes.
    noCanto(amiga(_, _, _, _, peixes, _), ListaSolucao),

    % A garota do signo de Câncer tem o sobrenome Dias.
    member(amiga(_, _, dias, _, cancer, _), ListaSolucao),

    % A menina da mochila Azul está em algum lugar à esquerda da que gosta de suco de Maracujá.
    aEsquerda(amiga(azul, _, _, _, _, _), amiga(_, _, _, maracuja, _, _), ListaSolucao),

    % A menina que gosta de suco de Maçã está ao lado da que quer ver o Lobo-marinho.
    aoLado(amiga(_, _, _, maca, _, _), amiga(_, _, _, _, _, lobo_marinho), ListaSolucao),

    % A garota da mochila Amarela está em algum lugar entre a do signo de Peixes e a Cristina, nessa ordem.
    aEsquerda(amiga(_, _, _, _, peixes, _), amiga(amarela, _, _, _, _, _), ListaSolucao),
    aEsquerda(amiga(amarela, _, _, _, _, _), amiga(_, cristina, _, _, _, _), ListaSolucao),

    % A menina que gosta de suco de Caju está em uma das pontas.
    noCanto(amiga(_, _, _, caju, _, _), ListaSolucao),

    % Gisele é a dona da mochila Amarela.
    member(amiga(amarela, gisele, _, _, _, _), ListaSolucao),

    % Regina está em uma das pontas.
    noCanto(amiga(_, regina, _, _, _, _), ListaSolucao),

    % A garota que quer ver o Tubarão está em algum lugar entre a que gosta de suco de Uva e a que quer ver a Arraia, nessa ordem.
    aEsquerda(amiga(_, _, _, uva, _, _), amiga(_, _, _, _, _, tubarao), ListaSolucao),
    aEsquerda(amiga(_, _, _, _, _, tubarao), amiga(_, _, _, _, _, arraia), ListaSolucao),

    % Regras para garantir que todos os atributos sejam diferentes
    mochila(Mochila1), mochila(Mochila2), mochila(Mochila3), mochila(Mochila4), mochila(Mochila5),
    todosDiferentes([Mochila1, Mochila2, Mochila3, Mochila4, Mochila5]),

    nome(Nome1), nome(Nome2), nome(Nome3), nome(Nome4), nome(Nome5),
    todosDiferentes([Nome1, Nome2, Nome3, Nome4, Nome5]),

    sobrenome(Sobrenome1), sobrenome(Sobrenome2), sobrenome(Sobrenome3), sobrenome(Sobrenome4), sobrenome(Sobrenome5),
    todosDiferentes([Sobrenome1, Sobrenome2, Sobrenome3, Sobrenome4, Sobrenome5]),

    suco(Suco1), suco(Suco2), suco(Suco3), suco(Suco4), suco(Suco5),
    todosDiferentes([Suco1, Suco2, Suco3, Suco4, Suco5]),

    signo(Signo1), signo(Signo2), signo(Signo3), signo(Signo4), signo(Signo5),
    todosDiferentes([Signo1, Signo2, Signo3, Signo4, Signo5]),

    animal(Animal1), animal(Animal2), animal(Animal3), animal(Animal4), animal(Animal5),
    todosDiferentes([Animal1, Animal2, Animal3, Animal4, Animal5]).