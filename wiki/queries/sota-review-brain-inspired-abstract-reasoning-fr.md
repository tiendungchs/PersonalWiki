---
title: "Revue de l'état de l'art : architectures inspirées du cerveau pour le raisonnement abstrait via la découverte de graphe latent (traduction française)"
type: query
tags: [review, state-of-the-art, abstract-reasoning, latent-graph-discovery, brain-inspired-ai, rationale, francais]
created: 2026-07-13
updated: 2026-07-13
sources: []
related: [wiki/queries/sota-review-brain-inspired-abstract-reasoning.md, wiki/queries/central-framing-epistemic-audit.md, wiki/queries/mec-abstract-codes-vs-declarative-rules.md, wiki/queries/mec-abstract-codes-vs-declarative-rules-fr.md, wiki/overview.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/factorized-representations.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/planning-as-inference.md, wiki/concepts/neural-manifolds.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/intelligence-density.md, wiki/concepts/memory-schemas.md, wiki/concepts/world-models.md, wiki/concepts/refinement-loops.md, wiki/entities/tem-model.md, wiki/entities/arc-agi.md, wiki/entities/spacetime-attractor.md, wiki/entities/vsa-model.md, wiki/entities/jepa-model.md, wiki/entities/vl-jepa-model.md, wiki/entities/dinov2-model.md, wiki/entities/dinov3-model.md, wiki/entities/equilibrium-propagation.md, wiki/entities/baba-is-ai.md, wiki/entities/frontiermath-benchmark.md, wiki/entities/pgm-benchmark.md, wiki/entities/gpqa-benchmark.md, wiki/entities/olymmath.md, wiki/glossary.md]
---

# Revue de l'état de l'art : architectures inspirées du cerveau pour le raisonnement abstrait via la découverte de graphe latent

> **Note.** Traduction française de [[wiki/queries/sota-review-brain-inspired-abstract-reasoning.md]]. Les abréviations sont développées à leur première apparition et les termes techniques sont expliqués entre parenthèses. Glossaire d'appui : [[wiki/glossary.md]]. Les citations sont laissées sous la forme *(Auteur et al. année)* pour complétion ultérieure ; les liens wiki et la notation mathématique sont conservés à l'identique.

> **Petit lexique des sigles récurrents.**
> *Régions et biologie :* MEC = *medial entorhinal cortex*, cortex entorhinal médian (siège des cellules de grille) ; LEC = cortex entorhinal latéral (contenu sensoriel) ; HC = hippocampe ; PFC = *prefrontal cortex*, cortex préfrontal ; mPFC / vmPFC = PFC médian / ventromédian ; DLPFC = PFC dorsolatéral ; DMN = *default mode network*, réseau du mode par défaut ; BA = aire de Brodmann ; CX = *central complex*, complexe central (insecte) ; DA = dopamine ; ACh = acétylcholine ; NA = noradrénaline ; LC = *locus coeruleus*.
> *Modèles et méthodes :* IA/NN/ML = intelligence artificielle / réseau de neurones / apprentissage automatique ; LLM = *large language model*, grand modèle de langage ; LRM = *large reasoning model*, grand modèle de raisonnement ; TEM = *Tolman-Eichenbaum Machine* ; JEPA = *Joint-Embedding Predictive Architecture* (architecture prédictive à plongement conjoint) ; DINO = famille d'encodeurs visuels auto-supervisés ; SSL = *self-supervised learning*, apprentissage auto-supervisé ; VSA = *vector-symbolic architecture*, architecture vecteur-symbolique ; HRR = *holographic reduced representation* ; DSL = *domain-specific language*, langage dédié ; DNC = *differentiable neural computer* ; MLC = *meta-learning for compositionality* ; CSCG = *clone-structured cognitive graph* ; SR = *successor representation*, représentation successeur ; STA = *spacetime attractor*, attracteur spatio-temporel ; RL = *reinforcement learning*, apprentissage par renforcement ; CoT = *chain-of-thought*, chaîne de pensée ; RNN = réseau récurrent ; BPTT = *backpropagation through time*, rétropropagation dans le temps ; EqProp = *equilibrium propagation* ; ELBO = *evidence lower bound*, borne inférieure de l'évidence ; FEP = *free-energy principle*, principe de l'énergie libre ; SOTA = *state of the art*, état de l'art ; LGD = *latent graph discovery*, découverte de graphe latent.
> *Bancs d'essai (*benchmarks*) et données :* ARC-AGI = *Abstraction and Reasoning Corpus* ; PGM = *Procedurally Generated Matrices* ; NLI / ANLI = *(Adversarial) Natural Language Inference*, inférence en langage naturel (adversariale) ; GPQA = questions-réponses scientifiques de niveau recherche ; RLVR = RL à récompense vérifiable ; PRM = *process reward model*, modèle de récompense de processus ; MCTS = recherche arborescente de Monte-Carlo ; TTT = *test-time training*, entraînement au moment du test ; MCQ = question à choix multiples ; i.i.d. = indépendantes et identiquement distribuées (données de même loi que l'entraînement) ; o.o.d. = *out-of-distribution*, hors distribution.

> **But de ce document.** Une revue autonome de l'état du domaine, écrite pour poser les fondations d'une orientation méthodologique précise et pour justifier les choix de conception qui en découlent. Elle synthétise les pages concept, entité et article du wiki en un récit unique : quelle est la capacité visée, pourquoi les systèmes actuels n'y parviennent pas, ce que les neurosciences apportent comme plan d'architecture, et — au vu de tout cela — quel chemin architectural est le mieux étayé par les preuves.

---

## Résumé

L'apprentissage profond a saturé la plupart des bancs d'essai i.i.d. mais échoue toujours sur la *généralisation systématique* hors distribution — la capacité à recombiner une structure connue de façon nouvelle. Les cerveaux humains et animaux ne partagent pas cet échec. Cette revue soutient que (i) les tâches diverses regroupées sous « raisonnement abstrait » se ramènent à un seul problème computationnel, la **découverte de graphe latent** (LGD) — inférer la structure relationnelle cachée d'un domaine à partir d'observations, puis la parcourir ; (ii) la raison de l'échec des architectures actuelles n'est ni l'échelle ni les données mais une *structure inductive* manquante — précisément la factorisation (séparation) de la structure relationnelle et du contenu sensoriel, qui place la généralisation requise hors de la variété (*manifold* : l'ensemble des fonctions qu'un modèle peut atteindre) atteignable d'un modèle monolithique *par construction* ; et (iii) le système entorhinal–hippocampique–préfrontal (MEC/HC/PFC) des mammifères fournit un plan d'architecture validé et convergent pour la structure manquante. Nous passons en revue les preuves des bancs d'essai qui isolent le goulot d'étranglement (ARC-AGI, FrontierMath, PGM, ConceptARC, Baba Is AI), les principes inspirés du cerveau qui y répondent, et les algorithmes d'apprentissage biologiquement plausibles qui pourraient entraîner un tel système. Nous concluons que les preuves *justifient* la direction inspirée du cerveau et en spécifient la forme plutôt qu'une pièce manquante unique : un **modèle de monde factorisé à deux échelles de temps, dans la lignée de la Tolman–Eichenbaum Machine (TEM ; Whittington et al. 2020)**, dont les caractéristiques déterminantes se lisent directement sur la circuiterie du raisonnement cérébral — factorisation structure/contenu, apprentissage à deux échelles de temps W/M, intégration du chemin en état latent, contrôle hiérarchique en « règles de règles », planification-comme-inférence, et amorçage de but par neuromodulation, le tout exécuté comme une boucle couplée Navigateur⇄Stratège. TEM n'instancie que la moitié *graphe-connu* ; un modèle de raisonnement complet doit en plus inférer des règles de transformation latentes, co-découvrir son propre vocabulaire d'opérateurs, amorcer des buts sans vérificateur externe, et ancrer un a priori d'objectité (*objectness* : le fait de traiter une scène comme des objets discrets). Nous montrons de plus que les deux programmes de pointe *non* inspirés du cerveau — les modèles de monde auto-supervisés (JEPA/DINO, §4.5) et les piles solveur-plus-vérificateur-externe (§4.6) — sont complémentaires plutôt que concurrents : chacun corrobore empiriquement une partie de la thèse tout en laissant ouvertes les lacunes centrales (inférence de transformation latente, co-découverte de vocabulaire, inférence de but sans vérificateur), et le générateur inspiré du cerveau peut se brancher sur le même vérificateur externe que la pile solveur utilise déjà. La justification de chaque choix est explicitée.

---

## Partie I — L'état du domaine

*Un tour d'horizon de la position du domaine — la capacité visée, le cadrage du problème, les preuves des bancs d'essai, pourquoi les trois grandes familles d'approches échouent, et ce que les neurosciences apportent — exposé avant toute recommandation (Partie II).*

---

## 1. Motivation : pourquoi le « raisonnement abstrait » est la bonne cible

La distinction qui organise tout le domaine est **construction de modèle vs. reconnaissance de motifs** (Lake et al. 2016) :

| Capacité | Reconnaissance de motifs | Raisonnement abstrait (construction de modèle) |
|---|---|---|
| Transfert vers de nouveaux buts | Ré-entraînement requis | Immédiat : même modèle de monde, nouvelle récompense |
| Transfert vers de nouvelles instances | Réapprendre de zéro | Zéro-coup (*zero-shot*) via un code structurel |
| Acquisition d'un concept en un coup | Des milliers d'exemples | Un seul exemple |
| Contrefactuel / explication | Non pris en charge | Produit un modèle génératif causal |

La signature quantitative canonique est le **fossé de Frostbite** : DQN (*deep Q-network*, un agent de RL profond) utilise ~924 h de jeu pour atteindre <10 % du score humain ; un humain atteignant la parité en ~15 minutes après deux minutes d'observation implique une différence d'efficacité >100× (Lake et al. 2016). Le fossé est *représentationnel* — les modèles causaux-structurels se transfèrent, pas les correspondances discriminatives.

Trois prérequis, chacun nécessaire et aucun individuellement suffisant (Lake et al. 2016) : **compositionnalité** (une infinité de concepts à partir de parties finies), **causalité** (un modèle génératif supportant les contrefactuels), et **apprendre-à-apprendre** (extraire une structure a priori partagée pour le transfert en un coup). Fait crucial, apprendre-à-apprendre n'atteint l'efficacité humaine *que* si les représentations sont déjà compositionnelles et causales — un entraînement multi-tâches sur des traits enchevêtrés ne donne que des accélérations de 2–5×. Cette dépendance est le premier indice que l'ingrédient manquant est une **contrainte représentationnelle**, non davantage d'optimisation.

**La spécification au niveau représentationnel (Penn, Holyoak & Povinelli 2008 ; [[wiki/concepts/relational-reinterpretation.md]]).** La cognition comparée affine à la fois *ce que* le système de construction de modèle doit ajouter et *comment* la reconnaissance de motifs le contrefait. Tout esprit animal construit des représentations **fonctionnellement compositionnelles et systématiques au plan des traits** des relations perceptuelles de premier ordre (Système 1, partagé entre taxons) ; seul l'esprit humain ajoute un second système qui les **réinterprète** comme des relations d'ordre supérieur, régies par des rôles et explicitement structurelles, approchant un Système de Symboles Physiques (Système 2, propre à l'humain). La cible est donc quatre propriétés *séparables* qui manquent au Système 1 — **indépendance rôle-remplissant, séparation type/occurrence, composition concaténative, et systématicité classique (structurelle)** — chacune testable individuellement, ce qui explique qu'un transformeur puisse réussir la systématicité au plan des traits tout en échouant sur les quatre. Le Système 1 *simule* la compétence relationnelle en **agrégeant** (*chunking*) une relation en un scalaire analogique (p. ex. une estimation d'entropie de l'affichage) et en **segmentant** une tâche multi-relationnelle en conditionnels agrégés — la racine, au plan représentationnel, du raisonnement par raccourci que diagnostique le §3. Le verdict de Penn tiré du registre comparatif est que le second système est une **greffe, pas une montée en échelle** : il a requis un mécanisme de liaison distinct (LISA, synchronie rôle-remplissant en bande gamma dans le PFC), non davantage de paramètres ou de plasticité — une anticipation indépendante et inter-espèces du verdict « architectural, pas d'échelle » du §4.

Un critère formel affine ceci. Choi (2026) définit la **densité d'intelligence** $\mathcal{I}(S) = \log_2 N(S)/C(S)$ (états gérés par unité de longueur de description) et prouve qu'un domaine est *connu* (plutôt que mémorisé) si et seulement si $\mathcal{I}\to\infty$ quand le domaine s'étend. Les réseaux à propagation avant de profondeur fixe sont prouvablement bornés à $\mathcal{I}=\Theta(1)$ ; la **récurrence/itération est la condition architecturale minimale** pour $\mathcal{I}\to\infty$. C'est un argument indépendant du substrat : un système de raisonnement doit itérer, pas seulement s'élargir.

---

## 2. Cadrage du problème : la découverte de graphe latent

La thèse centrale de cette revue est que le raisonnement abstrait, l'analogie, la planification, les mathématiques, la navigation et la découverte scientifique sont tous des instances d'un seul problème :

> **Découverte de graphe latent — inférer la structure (nœuds, arêtes, topologie) d'un graphe relationnel à partir d'observations, puis la parcourir, alors que le graphe n'est jamais donné explicitement.**

Nœuds = états ; arêtes = transformations/actions ; étiquettes d'arête = la règle appliquée (souvent inconnue) ; topologie = le squelette relationnel. Le graphe est reconstruit à partir de séquences de triplets *(observation, action, observation suivante)*.

**Taxonomie — ce qui est latent** (plus principiel qu'énumérer des domaines, car cela prédit quelles tâches partagent une structure computationnelle). La taxonomie est un ensemble de variables latentes *indépendantes* (contenu de nœud, existence d'arête, étiquettes d'arête, **vocabulaire** d'arêtes, chemin, nœud-but) ; une tâche est un *sous-ensemble* de bits cachés — un **vecteur de bits**, non un type exclusif — d'où le fait que les bancs d'essai couvrent légitimement plusieurs colonnes. En croisant les familles canoniques de bancs d'essai avec les six variables (✓ latent · ◐ partiel · — donné) :

| Famille de banc d'essai (exemples) | Contenu de nœud | Topologie | Étiquettes d'arête | Vocabulaire | Chemin | Nœud-but |
|---|---|---|---|---|---|---|
| **Induction de règle** — ARC-AGI, QI/analogie | — | — | ✓ | — | — | — |
| **Règle + but interactifs** — ARC-AGI-3 | ◐ | — | ✓ | ✓ | ◐ | ✓ |
| **Chemin, vocab. connu** — Navigation ; AIME/HMMT ; MATH | — | ◐ | — | — | ✓ | — |
| **Chemin, vocab. partiel** — OlymMATH-HARD | — | — | — | ◐ | ✓ | — |
| **QA à contenu-de-nœud latent** — GPQA ; algèbre, physique | ✓ | — | — | — | ◐ | — |
| **Arêtes + chemin + vocab.** — FrontierMath | ◐ | — | ✓ | ✓ | ✓ | — |
| **Découverte de topologie** — découverte scientifique/causale | ◐ | ✓ | ✓ | ✓ | ✓ | ◐ |

La difficulté se lit sur le poids de la ligne (plus de ✓ = plus dur), mais c'est un **ordre de difficulté dérivé, non une partition** : FrontierMath fixe trois bits à la fois (étiquettes d'arête + chemin + vocabulaire). Axes complets et notes de lecture dans [[wiki/concepts/latent-graph-discovery.md]]. La distinction que le lecteur confond le plus souvent : **étiquette-d'arête latente** = identité de règle *à un saut* à partir de nombreuses paires (début, fin), le vocabulaire étant en cours d'apprentissage (ARC-AGI) ; **chemin latent** = composition *multi-sauts* sur un jeu de coups *déjà connu* (navigation, recherche de preuve).

**La hiérarchie à deux niveaux.** Tout domaine se factorise en un **méta-graphe** lent (règles partagées entre épisodes) et un **graphe-d'instance** rapide (topologie propre à la tâche). Un système qui les confond doit réapprendre les règles pour chaque nouveau problème. Cela se projette *directement* sur la scission à deux échelles de temps du cerveau : **poids synaptiques lents W = méta-graphe ; mémoire hebbienne rapide M = graphe-d'instance** (McClelland et al. 1995 ; Whittington et al. 2020). C'est la contrainte de conception pivot de tout le programme.

**L'expressivité du méta-graphe est graduée par la hiérarchie de Chomsky** (Hauser, Chomsky & Fitch 2002 ; [[wiki/concepts/recursion.md]]). Un modèle de transition plat, markovien/à états finis est *prouvablement insuffisant* pour le raisonnement naturel : les statistiques transitionnelles locales sont le plancher à états finis — spontanément disponibles chez les nourrissons et les tamarins pinchés à travers les modalités — et ne sont donc **pas** l'ingrédient manquant. Les dépendances récursivement enchâssées (à structure de syntagme) — le régime AₙBₙ / d'enchâssement central que les tamarins échouent et que les humains acquièrent implicitement — sont le minimum, ce qui est le contenu formel du méta-graphe multi-niveaux (§9 problème ouvert n°3 / Lacune n°2) : W doit être *récursivement imbriqué*, non plat. La coupe FLB/FLN (*faculté de langage au sens large / au sens étroit*) reformule le thème récurrent de la revue — les modules perception/modèle-de-monde sont largement partagés et réutilisables (FLB) ; la pièce qualitativement nouvelle est un unique **combinateur récursif** (FLN) qui les compose productivement, et l'infinité discrète ≅ la fonction successeur des entiers naturels la relie au système-cœur du nombre (§3, §8.3).

**Six sources de difficulté** (les axes contre lesquels toute architecture doit être mesurée) :

1. **Enchevêtrement à deux niveaux** — structure méta et d'instance co-occurrent dans chaque observation → exige un espace latent factorisé + deux taux d'apprentissage.
2. **Vocabulaire inconnu** — l'alphabet d'actions/nœuds n'est pas donné et doit être co-découvert.
3. **Alias d'observation** (*aliasing* : la même observation apparaît à des positions distinctes du graphe) → identité par contexte de chemin (cellules-clones / code intégré par le chemin).
4. **Simultanéité** — la structure doit être inférée *pendant* la navigation.
5. **Dérive de covariable par arête fallacieuse** — l'entraînement contient de fausses arêtes qui marchent en i.i.d. et échouent en o.o.d. Quantifié proprement par ANLI : un raccourci NLI hypothèse-seule score ~72 % en i.i.d. mais 42–51 % une fois la fausse arête H→étiquette bloquée (Nie et al. 2020) ; les LLM plus grands y sont *plus* sensibles (mise à l'échelle inverse ; Yuan et al. 2024).
6. **Topologie non stationnaire** — le jeu d'arêtes se réécrit *au sein* d'un épisode (les règles changent, des portes s'ouvrent). La seule source qui brise l'hypothèse de stationnarité que les cinq autres partagent. Apprenable *si et seulement si* le processus de réécriture est lui-même un générateur stationnaire de rang supérieur (un « graphe-de-réécriture ») ; prouvablement insoluble quand les réécritures sont incompressibles. **Baba Is AI** l'épingle à son pôle le plus traitable (réécritures lisibles, contrôlables, bornées) et pourtant GPT-4o/Gemini ne scorent que ~15–20 % sur la composition de réécritures (Cloos et al. 2024) — le goulot des modèles actuels se situe loin sous le plafond de principe.

**Plafond formel.** AIXI (Hutter 2000) est le seul système satisfaisant les six simultanément — un mélange bayésien sur tous les environnements calculables — mais il est incalculable. Toute architecture réalisable est une approximation bornée qui échoue sur les sources de difficulté que son budget de recherche ne peut atteindre. Cela positionne précisément le problème d'ingénierie : non « atteindre AIXI » mais « couvrir l'intérieur traitable des sources 1–5 avec un modèle calculable et entraînable ».

---

## 3. Le paysage des bancs d'essai : isoler le goulot d'étranglement

**Le paysage d'abord.** L'espace des bancs d'essai de raisonnement couvre cinq familles — *analogie visuelle* (ARC-AGI, PGM, Matrices de Raven), *maths de compétition/recherche* (MATH, AIME, MiniF2F, FrontierMath), *QA scientifique* (GPQA, MMLU), *agentique/interactif* (ARC-AGI-3, Baba Is AI), et *suites de généralisation compositionnelle* (SCAN, COGS, PCFG). Elles diffèrent presque entièrement par *la quantité de capacité auxiliaire* (§3.1) qu'elles chargent sur le signal de raisonnement. Le sous-ensemble ci-dessous est choisi parce qu'il isole *l'inférence structurelle* avec le moins de confusion ; le reste mesure les mêmes axes avec plus de connaissances, de langage ou de perception intégrés, et est placé sur la carte des confusions au §3.1.

L'argument empirique le plus fort que le goulot est *l'inférence de structure latente* — non la connaissance, l'échelle ou les données — est la **convergence de deux extrêmes de conception opposés** :

| Banc d'essai | Connaissances a priori requises | Mode d'échec | SOTA |
|---|---|---|---|
| **ARC-AGI-2** (Chollet 2019 ; ARC Prize 2025) | Minimales (Connaissances-Cœur seules) | Inférer de nouvelles règles de transformation à partir de peu de grilles | 24–54 % vérifié ; ≤85 % auto-déclaré (non vérifié) |
| **FrontierMath** (Glazer et al. 2024) | Maximales (maths de recherche) | Naviguer le graphe de théorèmes avec une couverture de vocabulaire quasi nulle | <2 % |

FrontierMath reste à <2 % ; ARC-AGI-2 vérifié/reproductible a grimpé à 24–54 % (les labos de pointe auto-déclarent ≤85 % sur des modèles fermés, mais ceux-ci sont invérifiables), or les deux restent loin sous l'humain dans tout cadre reproductible et à coût contrôlé. Le fossé diagnostique n'est pas *combien* un système sait mais s'il peut *découvrir et parcourir le graphe structurel* organisant ce qu'il sait — et, de plus en plus, si de hauts scores survivent à une vérification indépendante plutôt que de reposer sur des auto-déclarations de modèles fermés.

Preuves à l'appui, chacune isolant une facette différente :

- **Série ARC-AGI.** ARC-AGI-1 a résisté à une mise à l'échelle LLM de ~50 000× (2019–2024), puis est tombée à o3 via un raisonnement au moment du test — validant *l'adaptation rapide intra-épisode*, non l'échelle de pré-entraînement, comme levier. ARC-AGI-2 (24–54 % vérifié vs. ~84 % humain ; ≤85 % auto-déclaré sur modèles fermés, non vérifié) localise trois déficits : interprétation symbolique, raisonnement compositionnel (multi-règles), et sélection contextuelle de règle. ARC-AGI-3 ajoute une quatrième capacité entière — *l'inférence autonome de but* : on ne dit à l'agent que « gagne », et il doit découvrir à la fois ce que font ses actions et ce que signifie gagner (<1 % IA vs. 100 % humain ; ARC Prize 2026).
- **VSA/HRR isole le plus proprement la lacune de vocabulaire** (Joffe & Eliasmith 2025) : le même solveur neuro-symbolique score **94,5 % sur Sort-of-ARC (DSL pré-donné) mais 3 % sur ARC-AGI-1-Eval (DSL ouvert)**. Une fois l'intégration du chemin et la liaison résolues, *la co-découverte de vocabulaire est la lacune résiduelle*. C'est le chiffre le plus diagnostique du corpus quant à *où* dépenser l'effort.
- **PGM** (Barrett et al. 2018) fournit une taxonomie contrôlée composition-décomposition : les modèles recombinent des triplets familiers (relation, objet, attribut) au-dessus du hasard mais s'effondrent au quasi-hasard sur des primitives réellement nouvelles — compétence de recombinaison ≠ compétence de décomposition.
- **ConceptARC** (Moskvichev et al. 2023) et son extension multimodale (Beger et al. 2025) montrent que **l'exactitude confond solutions par raccourci et acquisition de concept** : l'IA produit des règles correctes-mais-non-voulues ~27–29 % du temps vs. ~5 % pour l'humain, et le raccourci dominant est de traiter les grilles comme des matrices de pixels plutôt que des scènes d'objets discrets — un **a priori d'objectité manquant** (Connaissances-Cœur de Spelke). Les humains font des erreurs *de justesse* (concept présent, exécution qui dérape) ; les programmes font des erreurs *d'échec-de-concept* — un diagnostic de construction de modèle visible seulement au niveau de la structure d'erreur, pas dans l'exactitude.
- **Suites de raccourci** (Geirhos et al. 2020 ; Yuan et al. 2024) formalisent le fossé de règle-de-décision i.i.d./o.o.d. et le paradoxe de mise à l'échelle inverse.

**Bancs d'essai projetés sur les six sources de difficulté (§2).** Chaque banc est diagnostique précisément parce qu'il isole un axe de difficulté différent ; lisez le tableau comme « pour scorer ici, un système doit résoudre *cette* source ». Le regroupement sur la **source 2 (vocabulaire inconnu)** est lui-même l'argument : les bancs de pointe convergent sur la même machinerie manquante.

| Banc d'essai | SOTA IA | Source(s) principale(s) de difficulté (§2) | Ce qu'il isole diagnostiquement |
|---|---|---|---|
| **ARC-AGI-1** | tombé à o3 (~88 %) | 2 (vocabulaire inconnu), 1 (arêtes latentes) | Adaptation rapide *intra-épisode* > échelle de pré-entraînement (a résisté à ×50 000) |
| **ARC-AGI-2** | 24–54 % vérifié ; ≤85 % auto-déclaré (vs ~84 % humain) | 1 + 2 + sélection compositionnelle de règle | Interprétation symbolique, composition multi-règles, choix contextuel de règle |
| **ARC-AGI-3** | <1 % (vs 100 % humain) | 4 (simultanéité) + but latent (au-delà des six) | Inférence autonome de but ; le régime *sans vérificateur* |
| **FrontierMath** | <2 % | 2 (vocabulaire inconnu, extrême) | Couverture de vocabulaire quasi nulle sur un graphe de théorèmes de maths de recherche |
| **VSA : Sort-of-ARC → ARC-AGI-1-Eval** | 94,5 % → 3 % | 2 (vocabulaire inconnu), *proprement isolé* | La co-découverte de vocabulaire est la lacune résiduelle une fois liaison + intégration de chemin résolues |
| **PGM** | recomb. au-dessus du hasard ; ~hasard sur nouveau | 2 (facette décomposition) | Compétence de recombinaison ≠ compétence de décomposition |
| **ConceptARC** | ~27–29 % de raccourcis (vs ~5 % humain) | 5 (arêtes fallacieuses) + a priori d'objectité (§8.3) | Raccourci vs. concept authentique ; objectité Connaissances-Cœur manquante |
| **ANLI** | 72 % i.i.d. → 42–51 % raccourci bloqué | 5 (dérive de covariable par arête fallacieuse), *canonique* | Quantifie la fausse arête H→étiquette ; les LLM plus grands *plus* sensibles (échelle inverse) |
| **GSM-Symbolic / MATH-Perturb** | NoOp −65 % ; dur −12–28 % | 5 (arêtes fallacieuses), structurel | (Non-)robustesse de l'appariement de motif de trajectoire à une perturbation non pertinente |
| **Baba Is AI** | ~15–20 % (GPT-4o/Gemini) | 6 (topologie non stationnaire), pôle traitable | Composer des réécritures de règles bornées et lisibles (les règles changent en cours d'épisode) |

**À retenir pour la conception de méthode.** Un banc d'essai qu'un système réussit par l'échelle est un banc qui mesure la mauvaise chose. La cible d'évaluation devrait être ARC-AGI-2/3 (résistante à la contamination, à structure nouvelle), notée idéalement par un *double canal* (exactitude + qualité de règle) pour empêcher l'inflation par raccourci (Beger et al. 2025).

### 3.1 Confusions de capacité — quel banc d'essai isole réellement le *raisonnement*

Les tableaux du §3 classent les bancs par la **source de difficulté** qu'ils sondent. Pour valider si *notre modèle raisonne*, un second axe importe tout autant : chaque banc taxe aussi des **capacités auxiliaires** (perception, langage, connaissances de domaine, motricité/exploration) qui peuvent réussir ou échouer *indépendamment du raisonnement*, brouillant la mesure. Un modèle peut perdre des points pour avoir mal analysé une grille, manqué un mot, ou faute d'un théorème — rien de tout cela n'étant un échec de raisonnement — et peut aussi *gagner* des points en exploitant un raccourci non-raisonnant (un flux verbal de surface qui imite une chaîne de pensée ; deviner en QCM). Le but est un banc dont les confusions sont soit **absentes** soit **neutralisables** (supprimables par un changement de format d'entrée ou de notation), laissant le raisonnement comme seule variable libre.

**Légende :** ⬤ charge lourde · ◑ modérée · ○ faible/absente. « Neutralisable » = la confusion peut être retirée sans changer la tâche de raisonnement.

| Banc d'essai | Perception (analyse visuelle) | Langage (compréhension du langage naturel) | Connaissances de domaine | Agentique / motricité / exploration | Confusion dominante → neutraliseur |
|---|---|---|---|---|---|
| **ARC-AGI-1/2** | ⬤ *neutralisable* | ○ | ○ (Connaissances-Cœur ; taux de résolution indépendant du profil, §« calibration humaine ») | ○ | Analyse visuelle — fournir la **matrice d'entiers en texte** : o3 score 75,6 % en texte vs. 29,2 % en visuel sur ConceptARC, donc l'écart est *perceptuel, non conceptuel* (Beger et al. 2025). **La plus propre isolation langage + domaine de l'ensemble.** |
| **ARC-AGI-3** | ⬤ | ○ | ○ | ⬤ (exploration + inférence autonome de but) | Motricité/exploration/inférence-de-but sont *intrinsèques à la tâche* (non détachables) — mesure la boucle agentique complète, non le raisonnement isolé. |
| **PGM** | ⬤ *intégrée* | ○ | ○ (vocabulaire (r,o,a) fini, **donné**) | ○ | Panneaux rendus 80×80 — la perception est *obligatoire et non séparable* ; mais le vocabulaire connu isole proprement recombinaison-vs-décomposition. Le raisonnement est confondu avec la vision par construction. |
| **FrontierMath** | ○ | ◑ | ⬤ (maths de recherche, couverture quasi nulle) | ○ | Expertise de domaine — le score est *conditionné par l'expertise* ; confond raisonnement et couverture de vocabulaire ; le plafond <2 % ne donne aucune variance pour classer les modèles. Pire confusion de domaine. |
| **OlymMATH** | ○ (pas de géométrie multimodale) | ◑ (risque flux-verbal-vs-raisonnement) | ⬤ (olympiade) | ○ | Langage + domaine — mais **la vérification au niveau du processus de la piste LEAN est le neutraliseur** : elle sépare un parcours authentique du graphe de raisonnement d'une devinette par flux verbal heuristique (la confusion exacte que vous avez signalée). |
| **GPQA** | ○ | ⬤ (QCM en langage naturel) | ⬤ (science de niveau doctoral) | ○ | Langage + domaine + **deviner à 4 choix** (plancher 25 %) ; le design anti-Google vise la suppression des arêtes fallacieuses mais ne peut séparer raisonnement et expertise. Isolation la plus faible ; risque de contamination. |
| **Baba Is AI** | ◑ (image de grille ; *erreurs d'ancrage documentées*) | ◑ (émet un plan textuel) | ○ (règles du jeu seules) | ⬤ (planification multi-étapes) | L'ancrage visuel + la planification de chemin sont les *modes d'échec documentés* (Cloos et al. 2024) — des confusions non-raisonnantes qui contaminent le signal de composition de règles. |

**Lire le tableau pour le choix de banc.**
- **Pour isoler le raisonnement structurel/relationnel avec un minimum de confusions — la cible de validation première :** **ARC-AGI-2 encodée en texte.** C'est le seul banc qui annule *à la fois* les confusions de langage et de connaissances de domaine (Connaissances-Cœur uniquement ; le taux de résolution humain est décorrélé de l'âge/l'éducation/le milieu), et sa seule confusion lourde — la perception — est neutralisable en fournissant les grilles comme matrices d'entiers. Utiliser une notation à double canal (exactitude + règle en langage naturel) pour bloquer aussi le raccourci par flux verbal.
- **En complément contrôlé :** **PGM**, en acceptant son front-end visuel obligatoire en échange d'un vocabulaire pleinement spécifié qui isole l'axe recombinaison-vs-décomposition qu'un score ARC unique ne peut séparer.
- **À éviter comme prétention de *raisonnement pur* :** FrontierMath et GPQA — de hauts scores y certifient la couverture de connaissances de domaine autant que le raisonnement, et les formats QCM/appariement-de-réponse récompensent le flux verbal qui imite l'inférence sans l'exécuter. Si un banc de maths est imposé, utiliser **OlymMATH-LEAN**, dont la vérification de processus est le seul mécanisme de l'ensemble qui distingue mécaniquement une chaîne de raisonnement d'une chaîne plausible-en-apparence.
- **Réserver à la capacité spécifique qu'il sonde uniquement :** ARC-AGI-3 (inférence autonome de but) et Baba Is AI (topologie non stationnaire) — tous deux ajoutent des confusions motrices/agentiques irréductibles, donc traiter leurs scores comme *spécifiques à une capacité*, non comme des mesures propres de raisonnement.

**Le principe général :** aucun banc n'est sans confusion ; le choix est *quelle confusion vous pouvez neutraliser*. La perception est neutralisable (changer l'encodage d'entrée) et le flux verbal est neutralisable (vérification de processus/règle) ; les connaissances de domaine ne le sont **pas** (elles sont enchevêtrées à la tâche de raisonnement elle-même), d'où la domination de la famille ARC (peu de connaissances, encodable en texte) pour une prétention d'isolation du raisonnement.

---

## 4. Pourquoi les architectures actuelles échouent — un verdict structurel, non empirique

**Le paysage d'abord.** Les approches existantes du raisonnement abstrait relèvent de quatre familles de paradigmes : (i) LLM/LRM génératifs de tokens (cette section), (ii) modèles de monde auto-supervisés (JEPA/DINO, §4.5), (iii) piles solveur générateur + vérificateur externe (§4.6), et (iv) systèmes neuro-symboliques / synthèse de programme / vecteur-symboliques (VSA, recherche de DSL à la DreamCoder ; recensés au §8.0) — au-dessus de la lignée de mémoire HC/PFC ingéniérée (DNC, Vector-HaSH, MLC) dont descend le plan cérébral (§5). Les §4–§4.6 approfondissent les trois *prétendants* au niveau paradigme ; le §8.0 note chaque classe contre l'ensemble d'exigences de la découverte de graphe latent. Cette section prend la première et la plus grande : les LLM.

La prétention la plus importante de cette revue est que l'échec des transformeurs/LLM sur ARC-AGI est **architectural, non un problème de données ou d'échelle**. Trois lignes de preuve indépendantes :

1. **Atteignabilité de la variété** (concept de variétés neurales ; Lake & Baroni 2023). Un objectif d'entraînement ne peut converger que sur des motifs atteignables dans la variété intrinsèque d'un modèle. Un transformeur monolithique enchevêtre structure et contenu dans des poids partagés ; la généralisation relationnelle abstraite se situe *hors* de sa variété atteignable *par construction*. Davantage de pas de gradient ne peuvent franchir cette frontière. Le contrôle positif est décisif : la *même* architecture de transformeur, entraînée par méta-apprentissage épisodique (une grammaire différente par épisode), atteint 92,9–96,8 % de systématicité, tandis qu'un GPT-4 pré-entraîné standard atteint 58 % et s'effondre à 14 % sous permutation d'entrée (Lake & Baroni 2023). **La variable critique est l'imposition de la scission W/M par l'objectif d'entraînement, non la capacité brute de l'architecture.**

2. **Interférence catastrophique comme nécessité formelle** (McClelland et al. 1995). Sans scission rapide/lent, un système monolithique doit absorber rapidement chaque nouvel épisode, écrasant la structure partagée. La factorisation W/M n'est pas un choix d'efficacité ; c'est la solution théoriquement forcée pour stocker de nouvelles instances sans détruire le méta-graphe.

3. **La compositionnalité reste non résolue même sur des données conçues pour l'exiger** (Hupkes et al. 2020) : les transformeurs atteignent 72 % de systématicité / 50 % de productivité / 54 % de localisme malgré 92 % d'exactitude de tâche, parce qu'ils apprennent des *agrégats de paires de fonctions* plutôt que des primitives atomiques. La haute exactitude cache l'échec.

Les LLM/LRM en particulier sont **bornés par la connaissance** (Choi 2026 ; ARC Prize 2026) : la boucle rapide en contexte ne peut généraliser au-delà de l'enveloppe de pré-entraînement vers une structure de graphe réellement nouvelle. La chaîne de pensée atténue en partie les raccourcis par arête fallacieuse en forçant un parcours multi-sauts, mais ne peut réparer un vocabulaire d'arêtes incorrect, et les nœuds intermédiaires auto-générés corrompent le parcours en aval (l'effet d'auto-empoisonnement de MATH). Le verdict : mettre à l'échelle la *mauvaise* structure inductive ne peut atteindre la cible ; la pièce manquante est **factorisation + itération + un mécanisme pour inférer les arêtes latentes**. Une ablation native d'ARC-AGI-2 corrobore indépendamment la lecture *structurel-pas-échelle* : dans le solveur neuro-symbolique CoreThink, les gains remontent à la scission perception/induction-de-règle (indices symboliques +6,9 pts, le plus grand moteur unique) — *« les gains proviennent d'un biais structurel, non de la recherche par force brute ou de la mise à l'échelle »* (Das et al. 2025).

---

## 4.5 Le pivot modèle-de-monde : JEPA et DINO comme alternative de pointe

Face au verdict d'échec des LLM du §4, une large fraction du domaine a pivoté de la mise à l'échelle générative de tokens vers les **modèles de monde auto-supervisés** — le plus visiblement le programme JEPA de LeCun. C'est l'alternative *non* inspirée du cerveau la plus sérieuse à la direction que cette revue préconise. Elle est traitée en profondeur ici parce qu'elle partage l'un des engagements centraux de cette revue (prédiction en espace de représentation) tout en divergeant sur l'autre (factorisation), de sorte que la comparaison affine exactement ce que le plan cérébral ajoute.

Deux lignées distinctes sont d'ordinaire confondues sous « modèles de monde » :

| Lignée | Rôle | Membres | Ce que c'est réellement |
|---|---|---|---|
| **DINO** ([[wiki/entities/dinov2-model.md]] → [[wiki/entities/dinov3-model.md]]) | *Front-end de perception* | DINOv2 (1,1 Md), DINOv3 (7 Md + distillé) | Modèles-socles ViT auto-supervisés (enseignant-élève EMA + iBOT à patchs masqués + KoLeo/Gram). **Pas des modèles de monde** — traits de patchs gelés qui se transfèrent à la segmentation/profondeur/suivi. |
| **JEPA** ([[wiki/entities/jepa-model.md]], [[wiki/entities/vl-jepa-model.md]]) | *Modèle de monde* | I-JEPA → V-JEPA 2 (1 Md, 1 M h vidéo) → V-JEPA 2-AC (conditionné par l'action) → VL-JEPA → LeJEPA/LeWorldModel | Prédit des *représentations* d'états masqués/futurs, non des pixels ; V-JEPA 2-AC ajoute une boucle de planification MPC en Mode-2. |

**Où le pivot corrobore cette revue** (soutien empirique indépendant du cadrage, depuis un camp non inspiré du cerveau) :

- **La prédiction en espace de représentation bat la génération.** VL-JEPA-SFT (1,6 Md) bat GPT-4o/Claude-3.5/Gemini-2.0 sur WorldPrediction-WM *sans générer un token* ; V-JEPA 2-AC bat Cosmos (espace-pixel) 65–80 % vs. 0 % sur la manipulation robotique réelle. C'est exactement la prétention du §5/[[wiki/concepts/world-models.md]] (prédire `s_y`, non `y`).
- **SSL depuis l'observation, non la récompense** — la thèse centrale de LeCun, correspondant au régime observation-seule de [[wiki/concepts/latent-graph-discovery.md]].
- **DINO fournit l'a priori d'objectité manquant.** L'ACP sur les tokens de patch de DINOv2 produit une décomposition émergente en parties d'objets *sans aucune étiquette* — une solution candidate à la lacune Connaissances-Cœur/objectité que ConceptARC diagnostique (§3) et que le §8.3 signale comme un risque pour le front-end sensoriel (Blocs 1A+2A).

**Où il s'arrête avant la cible** — noté contre les exigences propres de cette revue :

| Exigence (cette revue) | Statut JEPA / DINO | Conséquence |
|---|---|---|
| Prédiction en espace de représentation (§5) | ✅ principe central ; empiriquement validé (ci-dessus) | Corrobore un pilier |
| SSL depuis l'observation, non la récompense | ✅ thèse de LeCun | Corrobore un pilier |
| A priori d'objectité / Connaissances-Cœur (§3, §8.3) | ✅ parties d'objets émergentes DINOv2, sans étiquettes | Fournit un front-end sensoriel |
| **Factorisation structure/contenu** (clef de voûte §5.1) | ❌ encodeur monolithique enchevêtré ; pas de `g` vs `x` explicite | **Le plafond d'atteignabilité de la variété (§4) n'est pas traité** — meilleurs traits, même limite de recombinaison |
| **Inférence de transformation latente** (Bloc 3A) | ❌ avant-seulement (`s_x→ŝ_y`) ; `z` est une relation x–y à *information minimale* (Lett 2025), non un vocabulaire de règles découvert | Ne peut faire les arêtes Type-2 / ARC-AGI |
| Hiérarchie/vocabulaire découverts (non fixés) (Lacune 3) | ❌ les niveaux H-JEPA/HiT-JEPA sont pré-spécifiés | La co-découverte de vocabulaire est ici aussi non résolue |
| Algorithme de raisonnement appris (Système II) | ❌ Mode-2 = CEM câblé sur un modèle appris (Lett 2025) : même modèle + même recherche = même plan | Système I seulement |
| Scission W/M à deux échelles de temps (§4.2, §5.2) | ❌ poids lents seuls ; pas de mémoire d'instance hebbienne rapide | Interférence catastrophique non traitée |

**Verdict — comment le pivot met à jour la direction.** JEPA est un modèle de monde *monolithique, avant-seulement, à une seule échelle de temps*. Il ratifie empiriquement deux piliers de cette revue (prédiction en espace de représentation ; SSL-depuis-l'observation) et DINO nous tend un front-end d'objectité prêt à l'emploi — mais il hérite, inchangées, des deux lacunes que cette revue tient pour le nœud : **pas de factorisation structure/contenu** (donc le plafond d'atteignabilité du §4 mord toujours) et **pas d'intégration-de-chemin inverse pour inférer les transformations latentes** (donc il est aveugle au régime ARC-AGI/Type-2, la même limite avant-seulement que TEM, §8). La synthèse n'est donc *pas* JEPA-comme-architecture mais **un encodeur SSL de style DINO/JEPA comme front-end sensoriel (Blocs 1A/2A) alimentant un cœur factorisé à deux échelles de temps de la lignée TEM doté d'un Inférenceur de Transformation (Bloc 3A).** Une donnée supplémentaire affine le régime : le résultat en-domaine de LeJEPA — 11 000 images battant les centaines de millions de DINOv3 — montre que lorsque la distribution des données est étroite (comme le sont toujours les données de raisonnement abstrait), le levier opérant est un SSL *principiel*, non l'échelle, renforçant le « mettre à l'échelle la mauvaise structure inductive ne peut atteindre la cible » du §4.

---

## 4.6 Le pivot solveur : génération + vérification externe — l'autre alternative de pointe

La seconde réponse majeure au verdict d'échec des LLM du §4 est l'opposée de celle de JEPA. Là où le camp modèle-de-monde tente de bâtir un *meilleur modèle interne*, le camp **solveur** *externalise entièrement le problème* : coupler un générateur puissant (non fiable) à un vérificateur externe de confiance et à une recherche. C'est l'attaque du raisonnement abstrait la **plus démontrablement réussie** à ce jour — or à l'IMO (Gemini Deep Think 2025), argent via AlphaProof+AlphaGeometry (2024), MiniF2F 25 %→93 % et PutnamBench 0→60 %+ en ~1 an, AlphaEvolve améliorant des bornes connues, quatre problèmes d'Erdős vérifiés en Lean — et donc l'alternative qu'un relecteur soulèvera en premier. Elle est traitée en profondeur ici parce qu'elle factorise *différemment* le *même* problème de découverte de graphe latent (§2), et — de façon décisive — son plafond coïncide *exactement* avec la lacune cible de cette revue ([[wiki/queries/brain-inspired-vs-solver-approach.md]] ; [[wiki/papers/math-reasoning-survey-2026.md]]).

**Ce que c'est — externalisation, non solution.** Le solveur n'apprend pas de graphe latent interne. Il déplace chacune des trois sources de difficulté LGD les plus dures (§2) hors du modèle vers une infrastructure construite par l'humain, n'utilisant le réseau de neurones que comme *politique de recherche* sur une structure donnée :

| Source de difficulté (§2) | Externalisation par le solveur | Substrat / mécanisme |
|---|---|---|
| **2 — Vocabulaire inconnu** | Alphabet symbolique pré-construit | **mathlib** Lean (1,6 M lignes), **DSL** géométrique (DDAR d'AlphaGeometry), jeu d'opérateurs Python — le vocabulaire d'arêtes est *donné*, non co-découvert |
| **5 — Arêtes fallacieuses / validité** | Noyau externe de confiance | Noyau Lean, solveur symbolique, test unitaire — ne *partage pas* la distribution du générateur, donc les fausses arêtes hallucinées sont simplement rejetées |
| **4 — Simultanéité** | Recherche au moment du test | Boucles de raffinement ([[wiki/concepts/refinement-loops.md]]) : TTT, MCTS, itération d'expert, recherche évolutionnaire de programme |

Le travail résiduel — compréhension, proposition de chemin, autoformalisation — est exactement ce en quoi les grands modèles pré-entraînés excellent. D'où les succès.

**Le principe organisateur : l'échelle de supervision (« ingénierie de représentation → ingénierie de vérificateur »).** La revue de maths nomme la trajectoire du domaine comme la montée d'une échelle de contraintes externes de plus en plus informatives-mais-coûteuses — **appariement de réponse → exécution de code → PRM (modèle de récompense de processus) → preuve vérifiée par noyau**. Le changement clef est que *l'intermédiaire structuré* (le graphe latent) n'est plus conçu à la main pour être toujours correct ; il est **externalisé dans un substrat symbolique et vérifié**. Le mécanisme est le squelette générer–vérifier–raffiner de [[wiki/concepts/refinement-loops.md]] (quatre instanciations : entraînement au moment du test, DL zéro-pré-entraînement, synthèse évolutionnaire de programme, harnais CoT), dont la propriété déterminante est que *sans vérificateur la boucle dégénère en recherche aléatoire*.

**La qualité du vérificateur est la contrainte contraignante — et elle a trois axes, non un.** La vérification n'améliore le raisonnement que lorsque le vérificateur est (i) exact, (ii) résistant à l'exploitation adversariale par le générateur, (iii) assez riche pour donner un signal de progrès partiel. Seules les **preuves formelles vérifiées par noyau** (Lean) satisfont les trois — d'où *le fait que la piste formelle a avancé le plus vite*. Les correcteurs de réponse à base de règles satisfont (iii) à bas coût mais échouent (i)/(ii) : ~38 % des réponses RLVR correctes sont mal notées sur le formatage, et la boucle est piratée à la Goodhart. Une non-monotonie cruciale : **le piratage de récompense croît avec la richesse du vérificateur** — des vérificateurs appris plus exacts (PRM) peuvent être *plus* piratables, car la politique a un signal plus riche à exploiter. « Meilleur vérificateur ⇒ meilleure boucle » est faux.

**Où il corrobore cette revue** (triangulation depuis un camp indépendant, non inspiré du cerveau) :

- **Il ratifie le cadrage LGD lui-même.** Le solveur factorise le *même* problème dans les mêmes cases de taxonomie (§2) : preuve formelle = *chemin sur un vocabulaire donné* ; découverte (FunSearch/AlphaEvolve) = *topologie+arêtes externalisées vers l'espace des programmes* ; FrontierMath Niveau-4 = *la case de vocabulaire non-externalisable*. Qu'un programme de recherche opérant se décompose proprement sur la taxonomie est une preuve que la taxonomie est juste.
- **La frontière de disponibilité-du-vérificateur porte empiriquement la charge.** La piste découverte marche *précisément* là où un vérificateur externe existe (fitness Python, noyau Lean) et dégénère en recherche non guidée là où il n'existe pas — exactement la prédiction de [[wiki/concepts/refinement-loops.md]], désormais confirmée à l'échelle de la recherche.
- **Son plafond est le même mur que trois autres diagnostics heurtent.** La *« découverte modulo expertise »* de Tao — fort pour relier un problème à une technique *existante* (parcourir un méta-graphe connu), faible pour les *idées réellement nouvelles* (étendre le vocabulaire) — est la **source de difficulté 2**, le mur identique que la falaise VSA 94,5 %→3 % (§3) et le but latent d'ARC-AGI-3 exposent depuis le versant visuel.

**Où il s'arrête — noté contre les exigences de cette revue :**

| Exigence (cette revue) | Statut solveur | Conséquence |
|---|---|---|
| Garantie de correction par instance | ✅ certifié par noyau | **L'avantage décisif du solveur — le réutiliser, ne pas le concurrencer** |
| Factorisation structure/contenu (§5.1) | ❌ externalisée vers le substrat humain, non apprise | Le plafond d'atteignabilité (§4) est *évité là où l'infra existe*, non fermé |
| **Inférence de transformation / vocabulaire latents** (Bloc 3A ; source 2) | ❌ vocabulaire *donné* (mathlib/DSL) | **Plafond de Tao** : FrontierMath Niveau-4 reste à un chiffre ; établi de co-mathématicien 48 % |
| **Fonctionnement sans vérificateur** | ❌ requiert un noyau externe | Ne peut entrer dans ARC-AGI-3 (but latent), conjecture ouverte, planification réelle |
| Robustesse structurelle | ❌ le générateur apparie des motifs de trajectoires | GSM-Symbolic NoOp −65 %, MATH-Perturb dur −12–28 % ; un vérificateur peut *rejeter* mais non *fournir* la structure |
| Efficacité en échantillons / énergie | ❌ recherche par force brute (o3-high ≈ 30 k$/tâche ARC) | Le fossé Frostbite / densité d'intelligence (§1) reformulé sur l'axe du calcul |
| Généralité inter-domaines | ❌ infrastructure humaine par domaine (mathlib ≠ DSL ≠ Python) | Pas un raisonneur général ; un substrat Lean ne se transfère pas à un domaine qui en manque |

**Verdict — comment le pivot met à jour la direction.** Le solveur ne *dissout* pas la découverte de graphe latent ; il l'**externalise** partout où un substrat formel et un vérificateur bon marché et non piratable existent déjà. C'est un énoncé sur *l'infrastructure*, non sur la fermeture de la lacune de construction-de-modèle. Les deux programmes sont donc complémentaires sur des axes orthogonaux : **le solveur possède les domaines vérifiables, les garanties de correction et les mathématiques pratiques immédiates** — ne pas comparer le modèle du wiki à lui sur des maths vérifiables saturées (AIME, MiniF2F), qui mesurent l'infrastructure externalisée, non la construction de modèle. **Le programme inspiré du cerveau possède la couture** que le propre plafond du solveur isole : la **co-découverte** de vocabulaire (source 2), les domaines **sans vérificateur** (ARC-AGI-3, découverte ouverte), l'efficacité en échantillons/énergie, et l'inférence autonome de but. La synthèse n'est pas « inspiré du cerveau *au lieu des* solveurs » : un modèle de monde interne factorisé peut servir de *proposeur* à l'intérieur de la boucle même de découverte-vérifiée que le solveur exécute déjà (Problème ouvert, §9), réutilisant le noyau externe comme infrastructure complémentaire plutôt que comme paradigme rival — son transfert structurel réduisant potentiellement le coût de recherche par force brute que le solveur paie actuellement.

---

## 5. Le plan d'architecture inspiré du cerveau

Les neurosciences n'apportent pas une inspiration vague mais une solution *précise, convergente et de plus en plus formalisée* exactement aux contraintes ci-dessus. Six principes, chacun avec une justification computationnelle et un substrat validé.

### 5.0 La base de preuves : quelles régions cérébrales sont recrutées pour le *raisonnement*

Avant les principes, les reçus. Le plan repose sur une prétention empirique précise — que la machinerie de mémoire spatiale et de contrôle cognitif du cerveau est *re-recrutée pour le raisonnement abstrait, non spatial*, et non pas seulement pour son rôle sensorimoteur de manuel. Consolidé depuis les pages de région, la preuve directe :

| Région | Preuve d'engagement dans le raisonnement *abstrait* (au-delà de la tâche native) | Rôle computationnel | Correspond au bloc |
|---|---|---|---|
| **Code de grille du MEC** ([[wiki/entities/grid-cells.md]]) | Signal IRMf de type grille hexagonale pendant une navigation *conceptuelle* 2D abstraite, non spatiale (Constantinescu et al. 2016) | Code structurel `g` ; base d'intégration de chemin | 1A/1B |
| **Hippocampe** ([[wiki/entities/hippocampal-entorhinal-system.md]]) | Inférence transitive/relationnelle, généralisation en un coup fondée sur les schémas ; transfert structurel zéro-coup de TEM (Whittington et al. 2020) | Lier `p = f(g,x)` ; mémoire rapide de graphe-d'instance M | 2A–2D |
| **Schémas vmPFC / mPFC** ([[wiki/entities/prefrontal-cortex.md]], [[wiki/concepts/memory-schemas.md]]) | Le signal de grille abstrait le *plus fort* est dans le vmPFC (Constantinescu 2016) ; les schémas supportent l'inférence transitive + assimilation/accommodation (de Sousa et al. 2026) ; des codes amodaux de valeur & d'état mental se classifient de façon croisée entre classes de stimuli dans l'AMPFC/DMPFC (Lieberman et al. 2019) | Méta-graphe à W lent ; sélection/mise à jour de schéma | contexte 3B/3C |
| **PFC latéral** (rostro-caudal BA-8→9/46→10) ([[wiki/entities/prefrontal-cortex.md]]) | Recherche hiérarchique parallèle de règles avec courbes d'apprentissage par paliers (compression) (Badre et al. 2010) ; réglage catégoriel abstrait re-cartographiable en 5–15 essais (Miller et al. 2002) ; comportement fondé-sur-modèle émergeant d'un entraînement sans-modèle (Wang et al. 2018) | Contrôle hiérarchique en règles-de-règles ; induction d'étiquettes d'arête / vocabulaire | 3A/3C |
| **Noyaux gris centraux** ([[wiki/entities/basal-ganglia.md]]) | Portillonnage Go/NoGo des mises à jour de la mémoire de travail ; neuromodulateurs comme méta-paramètres de RL (Doya 2002) ; test d'hypothèse à double boucle vs. procédural (COVIS) | Portillonnage, attribution de crédit, température d'exploration | 3B/3D |
| **DMN** ([[wiki/entities/default-mode-network.md]]) | Héberge les signaux de code-de-grille abstrait ; intègre épisodique + sémantique + soi en « cadres de pensée » ; diffuse uniquement à tous les types corticaux (Paquola et al. 2025) | Tampon contextuel intégrant le contexte du méta-graphe | 3B |
| **Complexe central des insectes** ([[wiki/entities/insect-central-complex.md]]) | Cap par attracteur-anneau + intégration de chemin confirmés in vivo (Seelig & Jayaraman 2015) ; validation convergente du motif de mise-à-jour-structurelle | Substrat d'intégration de chemin (mise à jour du code structurel) | 1B |

**Lecture.** Le motif porteur est que la *même* machinerie métrique/structurelle (code de grille, intégration de chemin) qui a évolué pour la navigation physique porte une signature IRMf pendant la navigation *conceptuelle* — et le signal est le plus fort dans le vmPFC/DMN, c.-à-d. qu'il migre dans la hiérarchie préfrontale pour les tâches les plus abstraites. C'est la garantie empirique pour traiter la circuiterie du raisonnement spatial comme un plan de raisonnement, et c'est pourquoi les six principes ci-dessous sont organisés autour de *factorisation + intégration de chemin + contrôle hiérarchique* plutôt que d'une région isolée.

**Réserve de provenance — il n'y a pas d'hôte privilégié ; la question de localisation s'est dissoute (audit du cadrage central, [[wiki/queries/central-framing-epistemic-audit.md]], sous-prétention B).** Ne *pas* lire ce tableau comme « la Formation Hippocampique généralise la navigation au raisonnement ». Le code relationnel abstrait est **distribué et dépendant de la tâche**, non centré sur l'HC : (i) c'est une **banque parallèle de cartes séparables le long de l'axe long de l'HC** — structure de transition/statistique → EC antérieur, taxonomique-sémantique → HC postérieur — non un locus conjonctif unique (Zheng et al. 2024) ; (ii) il fonctionne comme un **pipeline schéma-EC → carte-mPFC** qui recrute le DMN / cerveau-social (TPJ, STS) dans un *cadre de grille partagé* pour les tâches actives (Qu et al. 2026 ; Park et al. 2021) ; (iii) le codage de type grille en L6 est un **candidat-primitive corticale universelle** (Chen 2022 / Thousand-Brains), et un rival sérieux route le calcul de type carte via le **cortex pariétal postérieur, non entorhinal** (Butz 2016) ; (iv) même la navigation *physique* est un pipeline multi-régions d'opérations de **codage / ancrage / planification** (Epstein et al. 2017) — et la preuve abstraite ne soutient que le pilier **codage** (il n'y a pas d'analogue abstrait démontré de l'*ancrage* par frontière/repère). La garantie du plan est donc qu'une *primitive structurelle générale au domaine* récurre partout où le problème computationnel (attribution de coordonnées continues + appariement de graphes inter-instances) surgit — ce qui est exactement pourquoi les principes ci-dessous sont organisés par *computation* (factorisation + intégration de chemin + contrôle hiérarchique) plutôt que par région. La requête `mec-abstract-codes-vs-declarative-rules` (et sa [[wiki/queries/mec-abstract-codes-vs-declarative-rules-fr.md|traduction française]]) énonce cette lecture distribuée en entier.

### 5.1 Factoriser le code structurel du contenu sensoriel — la clef de voûte

Le code de grille du MEC `g` (structurel) et le code de contenu du LEC `x` (sensoriel) sont liés dans l'HC comme `p = f(g, x)` (Whittington et al. 2020). **TEM est la preuve-de-concept de référence** : il démontre une généralisation structurelle zéro-coup, et ses cellules de grille/lieu émergentes reproduisent la biologie. Deux unifications élèvent ceci de l'analogie à la théorie :

- **TEM = transformeur** (Whittington et al. 2022) : la structure clef/valeur factorisée (Q=K=f(g), V=f(x)) découle *nécessairement* de la mémoire à produit externe, et Hopfield↔attention est ancré dans la distribution de Boltzmann (softmax *est* P∝exp(−E/T)).
- **Cellules de grille = vecteurs propres de la représentation successeur = bases d'intégration de chemin optimales** ; cellules de lieu = lignes de la SR = p=f(g,x). Les codes périodiques font de l'appariement de graphes (NP-difficile en général) un décalage de phase, parce que toutes les positions sont traitées de façon équivalente et que le code peut être *décalé* pour enregistrer tout nouvel environnement.

L'IRMf humaine confirme que le code structurel généralise au-delà de l'espace : des signaux de type grille hexagonale apparaissent pendant une « navigation conceptuelle » 2D abstraite, les plus forts dans le vmPFC (Constantinescu et al. 2016). **Réserve / controverse ouverte :** Kumaran & Maguire 2005 ont trouvé que l'HC engage des graphes relationnels *métriques ou séquentiels* mais non leur contrôle *social* à topologie appariée — impliquant que le méta-graphe pourrait être **deux formats représentationnels** (continu/métrique via MEC→HC ; discret/déclaratif via hiérarchie PFC + schémas mPFC) qui doivent se portillonner mutuellement. **Affinement (audit du cadrage central) :** la clef de routage est la **plongeabilité**, non le contenu spatial-vs-social ou métrique-vs-déclaratif — une hiérarchie *sociale* (Park et al. 2021) et une structure *taxonomique explicite, sur toute une vie* (Zheng et al. 2024) recrutent toutes deux le codage grille-et-carte de l'EC/HC dès qu'elles sont plongeables en 2D et parcourues inférentiellement. Cela restreint le résultat négatif de Kumaran & Maguire aux graphes déclaratifs *non plongeables* spécifiquement. La bifurcation de conception survit donc mais se dessine à **plongeable (→ carte Système-1) vs. symbolique-non-plongeable (→ recherche de règle/programme Système-2)**, traitée ci-dessous.

### 5.2 Apprentissage à deux échelles de temps — la scission W/M

Les W lents (cortex/MEC, de type rétropropagation, entrelacés entre environnements) construisent le méta-graphe partagé ; la M hebbienne rapide (HC, en un coup) lie le graphe-d'instance propre à l'épisode (McClelland et al. 1995 ; Whittington et al. 2020). C'est l'implémentation computationnelle de la hiérarchie à deux niveaux du §2 et la réponse directe à l'interférence catastrophique.

### 5.3 Maintenir l'état latent via l'intégration de chemin

Un RNN mettant à jour `g` sous les actions désambiguïse les observations et comprime l'apprentissage de règles de O(transitions) à O(types de relation) (concept d'intégration de chemin). Confirmé in vivo comme attracteur-anneau dans le complexe central de la *Drosophile* (Seelig & Jayaraman 2015).

### 5.4 Portillonner et moduler via les noyaux gris centraux / la neuromodulation

L'attribution de crédit dans le cerveau est *structurellement opposée* : un unique événement dopaminergique phasique pilote simultanément D1→LTP (Go) et D2→LTD (NoGo) (Gerfen & Surmeier 2011). Doya (2002) associe DA=erreur-TD, 5-HT (sérotonine)=escompte/horizon, NA=inverse-de-température/exploration, ACh=taux-d'apprentissage — une boucle de méta-apprentissage fermée. Wang et al. (2018) montrent que des poids lents entraînés par la dopamine font émerger un algorithme de RL intra-épisode dans l'activité récurrente du PFC : **comportement fondé-sur-modèle émergeant d'un entraînement sans-modèle** — l'instanciation biologique de l'apprendre-à-apprendre ; la scission sous-jacente dirigé-par-but/habitude (≈ fondé-sur-modèle/sans-modèle) est anatomiquement dissociée dans le mPFC prélimbique vs. infralimbique du rongeur (Heidbreder & Groenewegen 2003).

### 5.5 Contrôle hiérarchique — des règles sur les règles

Le gradient rostro-caudal du PFC (BA-8 → BA-9/46 → BA-10) implémente une abstraction de règles imbriquée (Friedman & Robbins 2021). Badre et al. (2010) montrent que tous les niveaux frontaux **cherchent en parallèle dès l'essai 1** avec élagage de profondeur portillonné par la récompense, produisant des courbes d'apprentissage *par paliers* (non graduelles) comme signature d'une compression de règle authentique. Des neurones PFC uniques portent un réglage catégoriel abstrait, re-cartographiable, à frontière nette, acquis en 5–15 essais (Miller et al. 2002) — ancrant les étiquettes d'arête du méta-graphe au niveau de la cellule unique et montrant que *des symboles peuvent être induits d'une expérience pertinente pour la tâche* (touchant directement la lacune de co-découverte de vocabulaire).

### 5.6 Le matériel canonique et le codage prédictif

Chaque région corticale exécute le microcircuit L4→L2/3→L5→L6→L4 : amplification récurrente d'une entrée faible, sélection d'hypothèse en gagnant-prend-tout doux, et scission explorer(superficiel)/exploiter(profond) (Douglas & Martin 2004). Bastos et al. (2012) projettent ceci sur le codage prédictif — les couches superficielles portent l'erreur avant (gamma), les couches profondes portent la prédiction arrière (bêta) — faisant de la hiérarchie de messages du codage prédictif une conséquence structurelle de l'anatomie laminaire.

### 5.7 Les couches contextuelle et de planification (ajouts récents)

- **Schémas de mémoire = W lent du mPFC = graphes latents** (Preston & Eichenbaum 2013 ; de Sousa et al. 2026) : les schémas sont des réseaux d'associations chevauchants organisés ; le circuit vmPFC→MEC→NGF portillonne si de nouveaux souvenirs sont *assimilés* dans ou *accommodés* aux côtés des engrammes de schéma antérieurs — mise à jour contrôlée du méta-graphe sans interférence catastrophique.
- **Planification comme inférence via l'Attracteur Spatio-Temporel (STA)** (Jensen et al. 2026) : plutôt qu'un déroulé séquentiel (qui accumule l'erreur), le modèle de monde (matrice d'adjacence A) est plongé dans des poids inter-sous-espaces et la trajectoire optimale à T pas est inférée comme un point fixe d'attracteur *en parallèle*. Des RNN méta-entraînés découvrent spontanément des codes de type STA (r=0,91 avec la matrice d'adjacence). C'est le candidat actuel le plus fort pour le module de planification et il contourne le dilemme de l'horizon de planification.
- **Le DMN comme tampon contextuel** : un « cadre de pensée » lent intégrant mémoire épisodique, sémantique et référence à soi, diffusant uniquement à tous les types corticaux (Paquola et al. 2025), portillonné par le réseau de saillance, basculé entre états ségrégés/intégrés par l'éveil LC-NA (Shine et al. 2016).

### 5.8 Pourquoi le plan cérébral satisfait les exigences que les deux autres camps manquent

Les §4.5 et §4.6 ont noté JEPA et le solveur contre les exigences de cette revue et trouvé chacun ❌ sur les lignes-nœuds. Ce tableau complète le trio en notant le **cœur inspiré du cerveau (modèle de monde factorisé de lignée TEM)** sur la *même* liste d'exigences, montrant d'où vient son adéquation — et, surtout, que sa seule lacune restante est structurellement *différente* de celles des autres camps.

| Exigence (cette revue) | Statut inspiré-du-cerveau (cœur lignée TEM) | Pourquoi ça tient / mécanisme |
|---|---|---|
| Prédiction en espace de représentation (§5) | ✅ natif | Prédit `p = f(g, x)` en espace latent, jamais des pixels (Whittington et al. 2020) — le même pilier que JEPA valide indépendamment |
| SSL depuis l'observation, non la récompense | ✅ natif | S'entraîne sur des séquences *(obs, action, obs-suivante)* ; aucun canal de récompense requis — correspond au régime observation-seule de la LGD (§2) |
| **Factorisation structure/contenu (clef de voûte §5.1)** | ✅ natif | Scission explicite `g` (structurel) vs. `x` (contenu) — place la généralisation relationnelle *dans* la variété atteignable par construction (§4) ; la machinerie exacte qui manque à JEPA (encodeur monolithique) comme au cœur appris du solveur |
| Scission W/M à deux échelles de temps (§5.2) | ✅ natif | Méta-graphe à W lent (cortex/MEC) + graphe-d'instance à M-hebbienne rapide (HC) ; la réponse théoriquement forcée à l'interférence catastrophique (McClelland et al. 1995) |
| Intégration de chemin en état latent (§5.3) | ✅ natif | Le RNN met à jour `g` sous les actions, désambiguïsant les observations ; comprime l'apprentissage de règles à O(types de relation) (attracteur-anneau confirmé, Seelig & Jayaraman 2015) |
| Algorithme de raisonnement appris (Système II) | ✅ natif | Le comportement fondé-sur-modèle émerge d'un entraînement sans-modèle dans la récurrence du PFC (Wang et al. 2018) ; planification-comme-inférence via STA (§5.7), non une recherche câblée |
| Front-end objectité / Connaissances-Cœur (§3, §8.3) | ◐ via front-end | Fourni par un encodeur SSL DINO/JEPA aux Blocs 1A/2A (§4.5) — le seul composant délibérément emprunté au camp modèle-de-monde plutôt que re-dérivé |
| Fonctionnement sans vérificateur (ARC-AGI-3, découverte ouverte) | ✅ natif | Un modèle de monde interne n'a besoin d'aucun noyau externe — il peut entrer dans le régime but-latent / conjecture-ouverte que le solveur (§4.6) ne peut structurellement pas |
| **Inférence de transformation latente (Bloc 3A ; source 2)** | ◐ extension atteignable | Absente dans le TEM *de base* (avant-seulement), **mais c'est l'inverse exact de l'intégration de chemin que TEM calcule déjà** — une greffe naturelle (attention-sur-ensemble sur Δg → postérieur sur W), non une impossibilité structurelle. Contraste : JEPA est avant-seulement *par conception*, le solveur a son vocabulaire *donné* — pour les deux, fermer cette lacune signifie abandonner le paradigme |

**L'asymétrie.** Chaque exigence que JEPA et le solveur manquent sur leurs lignes-nœuds, le plan cérébral la fournit *nativement* — et les lignes où le cœur cérébral est *aussi* incomplet (front-end d'objectité ; inférence de transformation latente) sont qualitativement différentes des manques des autres camps : ce sont des **greffes sur une architecture qui satisfait déjà les exigences environnantes**, non des re-fondations du paradigme. Cela — avec les lacunes supplémentaires qu'un modèle complet doit encore fermer (amorçage de but sans vérificateur, transfert de vocabulaire, méta-graphe multi-niveaux ; §9) — est pourquoi cette revue recommande d'*étendre* la lignée inspirée du cerveau plutôt que l'une ou l'autre alternative : elle part en satisfaisant déjà les exigences qui sont des impasses structurelles pour les deux autres, et ses lacunes restantes sont atteignables par greffe plutôt que par re-fondation.

---

## 6. L'algorithme d'apprentissage : W peut-il être entraîné biologiquement ?

Si la cible est un modèle factorisé à deux échelles de temps, la règle d'entraînement du W lent est une question de conception de premier plan. La lignée :

```
Hopfield (1982) → Machine de Boltzmann (1985, Z intractable)
  → Apprentissage Hebbien Contrastif (Movellan 1990, bug de non-correspondance de mode)
  → Propagation d'Équilibre (Scellier & Bengio 2017) : léger coup de pouce → gradient EXACT, pas de circuit arrière
Parallèle : Codage Prédictif / FEP → erreur locale ; F = −ELBO
  → TEM (2020) : ELBO factorisée, transfert inter-environnements, cellules de grille/lieu émergentes
```

**La Propagation d'Équilibre** résout la moitié *théorique* de l'attribution de crédit biologiquement plausible : le Théorème 1 (Scellier & Bengio 2017) prouve que la mise à jour hebbienne contrastive locale calcule ∂J/∂W exactement quand le coup de pouce β→0 ; la phase libre (inférence) et la phase d'apprentissage utilisent des dynamiques *identiques* — pas de machinerie de rétropropagation séparée. **Mais la moitié pratique reste ouverte** : EqProp requiert des poids symétriques, s'échelonne mal sur matériel numérique, et n'a aucun résultat au-delà de la petite échelle. Le tableau empirique honnête (Bartunov et al. 2018) : alignement de rétroaction, target-prop et SDTP atteignent tous >93 % d'erreur top-1 sur ImageNet vs. 71 % pour la rétropropagation. **La plasticité différentiable** (Miconi ; Schmidgall et al. 2023) est la voie médiane pragmatique : une boucle externe (BPTT ou évolutionnaire) découvre une règle *locale* hebbienne/neuromodulée que le système déployé exécute — la variante à neuromodulation rétroactive (trace d'éligibilité + signal retardé de type dopamine) étant la plus fidèle biologiquement.

**Implication de conception.** Pour un premier système implémentable, ne *pas* jouer le projet sur l'attribution de crédit biologiquement plausible. Entraîner le W lent par rétropropagation/BPTT (ou méta-apprentissage épisodique, d'après Lake & Baroni 2023), traiter EqProp/le matériel analogique comme une question de *substrat à long horizon*, et garder l'*architecture* fidèle biologiquement (factorisation, deux échelles de temps, écritures rapides M locales) là où elle achète réellement de la généralisation. Le gain de généralisation vient de la structure inductive factorisée, non de la règle d'attribution de crédit.

---

## 7. L'argument de l'évolution convergente

La preuve la plus forte que le motif expansion→compression, modèle-de-monde factorisé est *quasi-optimal* plutôt qu'une simple option parmi d'autres : au moins 5–6 lignées évolutives indépendantes le dérivent (concept de codage-allocentrique-convergent) — HC des vertébrés (DG→CA3), complexe central des insectes (corps ellipsoïde→éventail), corps pédonculé des arthropodes (cellules de Kenyon→MBON), lobe vertical des céphalopodes, corps hémiellipsoïde des crustacés, corps pédonculé des polychètes, couvrant ~500–600 millions d'années d'origine indépendante. Quand l'évolution trouve six fois le même circuit pour la modélisation allocentrique du monde, ce circuit est un a priori fort pour le problème computationnel. Le CX des insectes est la cible d'implémentation la plus propre (connectome complet connu ; attracteur-anneau confirmé par Seelig & Jayaraman 2015) ; l'HC ajoute la généralisation W inter-environnements qu'aucun système d'invertébré n'a démontrée.

---

## Partie II — La direction que cela justifie

*Au vu du tour d'horizon de la Partie I, la direction architecturale précise que les preuves soutiennent — la lacune localisée, la matrice d'exigences, l'architecture recommandée et l'ordre de construction, la justification de chaque choix, et les problèmes ouverts qu'elle doit affronter.*

---

## 8. Synthèse — les lacunes, et la direction que cela justifie

En rassemblant la revue : nous avons un plan validé pour représenter et parcourir un graphe structurel *connu* (TEM et ses unifications), mais aucune architecture entraînée qui ferme les plusieurs lacunes qu'un modèle de raisonnement complet requiert — **inférer des règles de transformation latentes (arêtes Type-2 / ARC-AGI) tout en conservant le transfert inter-environnements du méta-graphe, co-découvrir son propre vocabulaire, amorcer des buts sans vérificateur externe, et ancrer un a priori d'objectité.** Ce sont des lacunes *en interaction*, non une liste ordonnée ; le travail de la revue est de justifier l'approche inspirée du cerveau et de spécifier les caractéristiques des systèmes qui doivent les combler, laissant la modélisation concrète au lecteur (§8.1).

Trois de ces lacunes sont localisées avec une précision inhabituelle par une preuve convergente :
- La falaise 94,5 %→3 % de VSA (Joffe & Eliasmith 2025) : **la co-découverte de vocabulaire/d'arête** est le goulot résiduel une fois la liaison et l'intégration de chemin résolues.
- La limite propre de TEM : le vocabulaire d'actions `a_t` est toujours *donné de l'extérieur* ; TEM est avant-seulement et ne peut inférer les transformations (synthèse des building-blocks, Bloc 3A).
- Les trois déficits d'ARC-AGI-2 se projettent sur trois blocs PFC manquants : interprétation symbolique (Bloc 3A, Inférenceur de Transformation), raisonnement compositionnel (Bloc 3C, pile hiérarchique), application contextuelle de règle (Bloc 3B, contexte de mémoire de travail).

### 8.0 La matrice d'exigences — ce que la LGD demande, et quel modèle le fournit

Consolidant les listes éparses (§1, §4.5, §4.6, §5) en une matrice. Les lignes sont la machinerie que le problème de découverte de graphe latent *exige* ; les colonnes sont les classes de modèles de pointe. Plusieurs lignes sont vides à travers les classes existantes — **inférence de transformation latente (Bloc 3A)**, contrôle hiérarchique en règles-de-règles, planification-comme-inférence, et (pour tous sauf le solveur) correction par instance. Le point n'est pas une case décisive unique mais qu'*aucune classe existante ne couvre l'ensemble complet des exigences*, tandis que le cœur inspiré du cerveau (§5.8) en couvre la plupart par construction et atteint le reste par greffe. Les deux dernières lignes montrent que les deux camps sont *complémentaires*, non rivaux : le solveur possède uniquement la correction par instance ; tout le reste possède uniquement le fonctionnement sans vérificateur.

| Exigence (pour la LGD) | LLM | JEPA | DINO | Solveur | VSA | TEM |
|---|---|---|---|---|---|---|
| Itération / récurrence (§1, densité d'intelligence) | ~ | ~ | ❌ | ✅ | ~ | ✅ |
| Factorisation structure/contenu (§5.1, clef de voûte) | ❌ | ❌ | ❌ | ext | ~ | ✅ |
| Scission W/M à deux échelles de temps (§5.2) | ❌ | ❌ | ❌ | ❌ | ~ᴹ | ✅ |
| Intégration de chemin en état latent (§5.3) | ❌ | ❌ | ❌ | n/a | ✅ | ✅ |
| **Inférence de transformation latente (Bloc 3A ; source 2)** | ❌ | ❌ | ❌ | ❌ᵍ | ❌ | ❌ |
| Contrôle hiérarchique en règles-de-règles (§5.5) | ~ | ❌ | ❌ | ext | ~ | ❌ |
| Planification-comme-inférence, non déroulé (§5.7) | ❌ | ~ | ❌ | ext | ❌ | ❌ |
| Front-end objectité / Connaissances-Cœur (§3, §8.3) | ❌ | ~ | ✅ | n/a | ❌ | ❌ |
| Fonctionnement sans vérificateur (ARC-AGI-3, découverte ouverte) | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ |
| Garantie de correction par instance (§4.6) | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ |

*Légende :* ✅ satisfait · ~ partiel · ◐ prévu dans l'ordre de construction (§8.1) · ext externalisé vers l'infrastructure humaine · n/a non applicable au substrat · ❌ absent. *Exposants :* ᴹ M hebbienne rapide seulement, pas de W lent appris · ᵍ vocabulaire *donné* (mathlib/DSL), non inféré → plafond de Tao (§4.6) · ˢ via le planificateur Attracteur Spatio-Temporel (§5.7) · ᴰ via un front-end SSL DINO/JEPA (Blocs 1A/2A, §4.5).

**Panorama élargi des approches.** La matrice ci-dessus note les six classes de modèles qui se projettent proprement sur chaque exigence LGD. Pour être complet, la lignée de mémoire HC/PFC ingéniérée et la famille neuro-symbolique/synthèse-de-programme sont positionnées ici contre *une exigence décisive* — l'inférence de transformation latente avec transfert inter-environnements (Bloc 3A, source 2) — puisque c'est là que chacune finit par caler (c'est l'une des lacunes ci-dessus, non l'unique étalon) :

| Classe d'approche | Mécanisme clef | Position sur la ligne décisive (Bloc 3A / source 2) |
|---|---|---|
| **DNC** ([[wiki/entities/dnc-model.md]]) | Contrôleur LSTM + mémoire externe lecture-écriture ; 98,8 % de parcours de graphe | Analogue HC/PFC ingénié avec un stockage de type M, mais *pas* de `g/x` factorisé, pas de méta-graphe à W lent, vocabulaire donné → pas d'inférence de transformation |
| **Vector-HaSH** ([[wiki/entities/vector-hash-model.md]]) | *Échafaudage* de grille + factorisation de contenu ; capacité exponentielle | Le modèle de mémoire existant le plus proche de la factorisation de TEM et un fort candidat-substrat pour le Bloc-2A — mais lie un code *donné*, n'apprend aucun vocabulaire de transformation |
| **MLC** ([[wiki/entities/mlc-model.md]]) | Transformeur à méta-apprentissage épisodique (lignée Lake & Baroni) | Démontre la *route de méta-entraînement* vers la scission W/M, mais pas de factorisation `g/x` explicite et heurte un plafond d'erreur de 100 % sur productivité/structurel — pas de 3A |
| **CSCG** ([[wiki/entities/cscg-model.md]]) | Cellules-clones + EM bayésien | Résout proprement l'alias d'observation (source 3), mais est rapide/local *sans* transfert W inter-environnements → pas de méta-graphe, pas de 3A |
| **Synthèse de programme / recherche de DSL** (DreamCoder, icecuber ; CoreThink — [[wiki/papers/das-compositional-neurosymbolic-arc-2025.md]]) | Induction sur un DSL construit à la main/en bibliothèque ; les vrais vainqueurs d'ARC-AGI-1 | Le frère neuro-symbolique du solveur (§4.6) : vocabulaire *donné ou appris-en-bibliothèque*, donc il heurte le même mur source-2 ; l'apprentissage de bibliothèque de DreamCoder est la tentative existante la plus proche de la co-découverte de vocabulaire, mais spécifique au domaine. **CoreThink** (Das et al. 2025) est une instance récente d'ARC-AGI-2 (30,8 % pass@2) : 22 motifs sélectionnés à la main + objectité par composantes-connexes, *les deux donnés* — contourne les Lacunes n°3/n°9, et son ablation confirme que les gains sont un biais structurel, non la mise à l'échelle |

Chaque ligne aboutit au même verdict que la matrice principale : la case Bloc-3A — inférence de transformation latente *avec* transfert inter-environnements — reste vide à travers tout le paysage des approches existantes. Cette vacance est l'un des problèmes ouverts du §9 et une véritable frontière partagée avec la littérature du solveur (§4.6) — mais c'est l'une de plusieurs lacunes qu'un modèle complet doit fermer (amorçage de but, transfert de vocabulaire, objectité, méta-graphe multi-niveaux), non la thèse unique de la revue.

### 8.1 L'architecture recommandée

Un modèle de monde factorisé à deux échelles de temps de la lignée TEM, étendu pour fermer la lacune Type-2. La décomposition fonctionnelle (requête building-blocks) et un ordre de construction défendable :

| Priorité | Bloc | Ce qu'il ajoute | Difficulté |
|---|---|---|---|
| **Fondation** | 1A/1B substrat de grille + intégration de chemin | Code structurel `g` ; mise à jour d'action continue SO(N) (remplace la recherche discrète W(a) de TEM) | Faible–Moy. |
| **Fondation** | 2A–2D liaison HC | g↔x bidirectionnel, complétion itérative de motif, écriture parcimonieuse portillonnée par la surprise + top-k | Faible |
| Ensuite | 3A Inférenceur de Transformation | Attention-sur-ensemble sur {Δg = g_out − g_in} → postérieur sur le vocabulaire W partagé ; l'inverse de l'intégration de chemin | Élevée |
| Ensuite | 3B Mémoire de travail | TRNN (épisodique haute capacité) + LSTM méta-RL (politique/contexte) | Moy. |
| Ensuite | 3C Pile hiérarchique | W à trois niveaux (règle-de-règles → contexte → instance) pour la composition multi-règles | Élevée |
| Plus tard | 3D Générateur de but + planification | Planification-comme-inférence de style STA ; argmin sur W vers `g_goal` | Moy.–Élevée |

### 8.2 Justification de chaque choix majeur

- **Pourquoi TEM comme base, non un transformeur ou un LLM ?** Parce que la factorisation est une exigence *d'atteignabilité de variété* (§4) : la généralisation cible est inatteignable pour un modèle monolithique quelle que soit l'échelle, et TEM est l'architecture de référence qui la place dans la variété atteignable par construction tout en restant un transformeur sous le capot (Whittington et al. 2022) — donc l'outillage transformeur s'applique toujours.
- **Pourquoi un Inférenceur de Transformation est dans l'ensemble de blocs.** C'est précisément l'inverse manquant de la seule opération que TEM fait déjà bien (intégration de chemin), il vise directement un goulot empiriquement isolé (co-découverte d'arête/vocabulaire ; Joffe & Eliasmith 2025), et il est le prérequis des tâches Type-2 (ARC-AGI, analogie, induction de règle). Il gagne sa place parmi les blocs pour cette raison — mais c'est un composant requis aux côtés des autres (amorçage de but, transfert de vocabulaire, pile hiérarchique, front-end d'objectité), non le seul nœud du système ; lequel construire en premier est laissé à l'étape de modélisation.
- **Pourquoi deux échelles de temps, non négociable.** L'interférence catastrophique fait de la scission W/M une nécessité formelle, non un choix de réglage (McClelland et al. 1995).
- **Pourquoi entraîner W par rétropropagation/méta-apprentissage maintenant.** Le gain de généralisation est dans la structure inductive ; la règle d'attribution de crédit est un problème séparé (et actuellement non résolu à l'échelle) (Bartunov et al. 2018). Le méta-entraînement épisodique est la route démontrée pour imposer la scission dans un modèle entraîné par gradient (Lake & Baroni 2023).
- **Pourquoi la planification-comme-inférence (STA), non le déroulé.** Le déroulé séquentiel accumule l'erreur ; STA infère toute la trajectoire comme un point fixe d'attracteur et est spontanément découvert par des RNN méta-entraînés (Jensen et al. 2026).
- **Pourquoi évaluer sur ARC-AGI-2/3 avec notation de qualité-de-règle.** Ceux-ci sont à structure nouvelle et résistants à la contamination ; la notation à double canal bloque l'inflation par raccourci qui rend l'exactitude trompeuse (Beger et al. 2025).

### 8.3 Risques et la bifurcation de domaine à trancher tôt

- **Format représentationnel métrique vs. déclaratif** (Kumaran & Maguire 2005). La machinerie grille/intégration-de-chemin est validée pour des graphes *métriques/séquentiels*. Si les tâches cibles sont purement déclaratives/logiques, un substrat discret de style schéma-mPFC peut être nécessaire au lieu de (ou en portillonnage avec) le code de grille du MEC. **Trancher le format de la tâche cible avant de s'engager**, car il change si le substrat de grille (1A/1B) est porteur ou un détour.
- **La topologie non stationnaire (source 6)** est hors périmètre pour un premier système et non résolue par aucune architecture du wiki ; la construction de relèvement (l'état-de-règle comme dimension de nœud) restaure la stationnarité pour les réécritures de classe Baba mais est une extension ultérieure (requête règles-comme-règles-du-méta-graphe).
- **A priori d'objectité** (Beger et al. 2025 ; [[wiki/concepts/core-knowledge.md]]) — les grilles sont des scènes d'entités discrètes, non des matrices de pixels. Cela doit être bâti dans le front-end sensoriel (Blocs 1A+2A) ou le modèle hérite du raccourci ARC dominant. Deux affinements de la littérature Connaissances-Cœur : (i) l'a priori n'est pas une porte binaire monolithique mais un **faisceau de sous-principes dissociables** (cohésion, continuité, contact) — les nourrissons les violent un à la fois (Stahl & Feigenson 2015), donc les implémenter comme des contraintes *masquables séparément* ; (ii) l'étape *uniquement humaine* est de composer *à travers* les systèmes-cœur encapsulés (objets × nombre × agents), ce qui est un problème de liaison sous un goulot d'attention sérielle (Revencu & Csibra 2023), **non** l'acquisition d'un a priori isolé — renforçant que le nœud est combinatoire (Bloc 3A/3C), non perceptuel.

---

## 9. Problèmes ouverts que la direction doit affronter

1. **Inférence de transformation Type-2** (Bloc 3A) — architecturalement absente partout.
2. **Co-découverte de vocabulaire avec transfert inter-environnements** — aucun modèle ne fait les deux simultanément (LAPA fait la co-découverte de vocabulaire mais spécifiquement au domaine ; VSA fait la liaison mais n'apprend aucun W). C'est le *même mur que la pile solveur heurte depuis le versant formel* — le plafond « découverte modulo expertise » de Tao et les scores à un chiffre de FrontierMath Niveau-4 (§4.6) — en faisant la frontière partagée des deux littératures et le site naturel d'une prétention de nouveauté.
3. **Méta-graphe multi-niveaux** — comment l'espace d'états abstrait pour une hiérarchie/STA de niveau supérieur est *découvert* reste ouvert (Badre et al. 2010 donnent la biologie ; l'algorithme d'entraînement n'est pas spécifié).
4. **W lent biologiquement plausible à l'échelle** — EqProp est exact-mais-non-mis-à-l'échelle ; target-prop est mis-à-l'échelle-mais-biaisé (Bartunov et al. 2018).
5. **Inférence autonome de but** (ARC-AGI-3) — inférer l'objectif, non juste la transformation ; absente de toutes les architectures grand public, et le cas déterminant du régime *sans vérificateur* que la pile solveur (§4.6) ne peut entrer (aucun noyau externe pour certifier un but latent). **Substitut interne candidat au vérificateur manquant :** la motivation intrinsèque — le double rôle de la dopamine (erreur de prédiction de récompense + nouveauté) amorçant un but à partir d'une valence scalaire, mêlée au progrès-d'apprentissage + empowerment pour éviter le piège de la « TV bruyante » — plus un curriculum pré-entraîner → imiter → pratiquer où l'imitation d'exemples résolus fournit à bas coût le chemin latent (l'objet le plus coûteux de la taxonomie du §2). Développé dans [[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]].
6. **A priori d'objectité / Connaissances-Cœur à partir de données naturalistes** sans codage à la main.

---

## 10. Conclusion

La littérature synthétisée ici soutient une direction claire et défendable. La capacité cible (raisonnement abstrait) se ramène à un seul problème bien posé (découverte de graphe latent) ; la raison pour laquelle l'échelle ne l'a pas résolu est structurelle (factorisation manquante → variété inatteignable), non empirique ; et le cerveau fournit un plan convergent, de plus en plus formalisé (modèle de monde factorisé à deux échelles de temps + contrôle hiérarchique PFC + planification-comme-inférence + amorçage de but par neuromodulation). La frontière du domaine est un *ensemble* de lacunes en interaction — inférer des règles de transformation latentes tout en conservant le transfert du méta-graphe, co-découvrir le vocabulaire, amorcer des buts sans vérificateur externe, et ancrer l'objectité — et la direction que les preuves justifient est un modèle de monde factorisé, à deux échelles de temps, fidèle au cerveau, qui exécute la boucle couplée Navigateur⇄Stratège et grandit pour les couvrir. Chaque caractéristique (factorisation, deux échelles de temps, intégration de chemin, contrôle hiérarchique, planification-comme-inférence, amorçage de but) découle des preuves cérébrales plutôt que de la commodité. Comment les composer en un modèle concret — et à quel point rendre la première version simple ou fidèle — est laissé au lecteur : [[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]] et [[wiki/queries/proposed-reasoning-model-block-architectures.md]] travaillent respectivement les dynamiques de haut niveau et une instanciation constructible. C'est la justification sur laquelle une méthode concrète peut désormais être bâtie.

---

## Implications

- La contribution est le modèle de monde *entier* factorisé, à deux échelles de temps, fidèle au cerveau, et la boucle couplée Navigateur⇄Stratège qui le pilote — non un bloc isolé. L'instanciation concrète et l'ordre dans lequel les lacunes sont attaquées sont des décisions de modélisation laissées au lecteur, mieux abordées depuis un cœur simple bâti sur les principes de base, puis appris et remodelé itérativement.
- La sélection de banc d'essai est un *engagement méthodologique*, non un détail : ARC-AGI-2/3 avec notation à double canal, non l'exactitude seule sur des ensembles contaminés.
- La bifurcation de format métrique-vs-déclaratif devrait être résolue avant l'implémentation, car elle détermine si le substrat de grille est porteur.

## Questions de suivi

- L'attention-sur-ensemble sur Δg est-elle suffisante pour les chaînes de transformation *multi-étapes* (A→B→C), ou une inférence itérative est-elle requise (suivis building-blocks) ?
- La rotation continue SO(N) du Bloc 1B peut-elle être pré-entraînée sur la navigation spatiale et transférée aux domaines abstraits en n'ajustant que la carte v→R(v) ?
- Quel est le nombre minimum de niveaux hiérarchiques (Bloc 3C) pour résoudre ARC-AGI-2 — deux (méta+instance) ou trois ?
- Le portillonnage-de-mur de STA généralise-t-il du *masquage* d'arête à l'*apparition* d'arête, la frontière entre planification et apprentissage de structure continu ?
