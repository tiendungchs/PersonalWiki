---
title: "Critical review of LeCun’s Introductory JEPA paper"
source: "https://malcolmlett.medium.com/critical-review-of-lecuns-introductory-jepa-paper-fabe5783134e"
author:
  - "[[Malcolm Lett]]"
published: 2025-03-28
created: 2026-06-23
description: "I review Yann LeCun (2022), A Path Towards Autonomous Machine Intelligence"
tags:
  - "clippings"
---
## I review Yann LeCun (2022), A Path Towards Autonomous Machine Intelligence

In 2022 Yann LeCun, a very well-known figure in the AI community and Chief Scientist at Meta AI, published a mixed opinion piece and technical paper [*A Path Towards Autonomous Intelligence*](https://openreview.net/pdf?id=BZ5a1r-kVsf) (LeCun, 2022). He outlines his theory for the basis of the next revolution in AI and introduces the Joint Embedding Predictive Architecture (JEPA) model architecture. Since then, JEPA has become a popular discussion topic and there is a lot of enthusiasm for what it might offer us. Meta has continued to progress their ideas and has since published I-JEPA (a foundation model for various kinds of image tasks, [Assran et al, 2023](https://arxiv.org/abs/2301.08243)) and V-JEPA (a foundation model for video tasks, [Bardes et al, 2024](https://arxiv.org/abs/2404.08471)).

It was the model-predictive basis and world-modeling capabilities that initially caught my eye. These are ideas that we’ve known about in human brain function for a long time, and so far they have proven difficult to incorporate into state-of-the-art ML. Upon further reading, I was both intrigued and bemused by how he relates his JEPA solution to a grander architecture for Autonomous Machine Intelligence (AMI).

And so here I will outline a few thoughts about LeCun’s vision for AMI. I will highlight both the good and the bad, and I will attempt to place JEPA into context with what I believe is needed for AMI that approaches human-like reasoning capabilities.

Read on if you want to know:

- how JEPA is not revolutionary, but it is a good next evolution
- how JEPA mode-1 and mode-2 are both forms of System I thinking
- how JEPA is only superficially like Predictive Coding and could learn a lot from it
- how “generational” is a confused term
- how JEPA is only slightly better at world modeling than auto-encoders
- and what’s going on with the debate between end-to-end training and knowledge-based optimizations

## Overview

I won’t waste time attempting to summarize the paper or related work. A good summary has been provided by Rohit Bandaru. There are also many videos online.

## [Rohit Bandaru | Deep Dive into Yann LeCun's JEPA](https://rohitbandaru.github.io/blog/JEPA-Deep-Dive/?source=post_page-----fabe5783134e---------------------------------------)

### ML blog.

rohitbandaru.github.io

Overall, I’m excited to see where JEPA and the larger Autonomous Machine Intelligence (AMI) architecture takes us. There’s a number of ways that LeCun’s proposal could help propel us towards some very interesting advancements.

The I-JEPA and V-JEPA work is already showing that JEPA enables the model to learn a more compact representation of the world than prior architectures. The I-JEPA model requires about 5x fewer iterations than comparable models (Assran et al., 2023, section 7). The focus on applying a loss against a higher-order representation has already been shown to improve training sample efficiency by a factor of [1.5x to 6x](https://ai.meta.com/blog/v-jepa-yann-lecun-ai-model-video-joint-embedding-predictive-architecture/).

The coolest hints of its efficiency come from the comparison plots on those papers:

![](https://miro.medium.com/v2/resize:fit:1228/format:webp/1*4YpbpFK5NfN-u5gFoIh0Vg.png)

I-JEPA scaling comparison to other techniques (source: Assran et al, 2023)

![](https://miro.medium.com/v2/resize:fit:1320/format:webp/1*txEczCLT5AUAfd0I58E6CQ.png)

V-JEPA scaling comparison to other techniques (source: Bardes et al, 2024)

I expect to see a lot of controversy over the cognitive/AMI architecture he described. More on that later. Nevertheless, I think the biggest benefit will be that it introduces these ideas of “cognition” to a wide ML audience who haven’t been previously exposed. While the architecture is over-simplified compared to anything even remotely human-like, by sharing these ideas as part of an otherwise technical paper on a key ML component, the ideas will start to disseminate. And junior researchers will start to take up some of the least defined components and begin to flesh them out (eg: the “configurator”).

Anyone who’s studied human cognition probably laments the lack of model-based prediction in ML today. While I have my doubts that JEPA reflects anything biological (see the section on Predictive Coding), and I have my doubts whether it is significantly better at world-modeling than existing networks, it at least introduces the ideas to the community and sets a new target.

Lastly, I’m very pleased to see the beginnings of attempts to incorporate “implicit cost” into these models. This represents a step towards the agent doing its own learning in the same way that biology does. I find the current training regimes more akin to having a computer plugged into your brain, *The Matrix-* style, that’s using some external rules and objectives to decide the weight updates. The agent itself doesn’t have any hope of accessing the underlying objective, so it can’t even reason and plan about that objective if it wants to. By incorporating the ideas of implicit cost and learned cost, we’ll be a step toward true autonomous agents.

## On Intelligence Architectures

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*oJ7f-pPRFbbrjfcW33f1lQ.png)

Autonomous Machine Intelligence vs JEPA (copied with modifications from LeCun, 2022)

LeCun devotes a considerable amount of the content of the paper to outlining a big picture view for the long term of machine intelligence, while at the same time remaining quite vague on the details. This is quite understandable, and very common. It’s understandable, because anyone who’s spent any time on this topic ultimately wants to see a solution for it, and the only way we will ever get a solution is to keep attempting based on all the collective knowledge that humanity has at the time. Any such attempt must start somewhere, even if it isn’t thoroughly fleshed out, with the hope that the details can be figured out over time. A sense of direction helps with the scientific endeavor.

It’s extremely common because almost anyone who’s worked on the question of intelligence has tried it. I, myself, have made many such drawings — most of them completely worthless. By way of example from someone else, here’s one of my favorites from [Aaron Sloman in 2007](https://www.cs.bham.ac.uk/research/projects/cogaff/sloman-aaai-consciousness.pdf), though he’d been working on versions of this since the 90s or even earlier:

![](https://miro.medium.com/v2/resize:fit:1150/format:webp/1*lbRDyBTvQh6k5svFJEjOUQ.png)

H-CogAff architecture (source: Slomon, 2010)

Where LeCun gets a little misleading is that he’s not clear enough that he’s applying inspiration from a subset of our current knowledge of intelligence, taking the *design stance*, and attempting to use that to engineer a solution for the next revision of artificial machine intelligence. In the introduction, he calls his diagram and associated descriptions “an overall cognitive architecture in which all modules are differentiable and many of them are trainable” (p. 2). The reference to cognitive architecture could make one assume that he’s talking about the brain here. In contrast, later on, he references it as the “proposed architecture for autonomous intelligent agents” (p. 7).

Minor niggles aside, the act of proposing such an architecture is also important. It sets the context for the other details that he explains, declaring how the technically specified components should relate to each other. It sets a reference point to guide future research — with others able to use it to identify future areas of research that may interest them.

Lastly, and perhaps most importantly, it begins to share important concepts with the very wide AI audience who don’t have any background in understanding human cognition. From the days of Turing, we have tried to replicate the amazing abilities of the human brain. Many of the ideas around computation have been inspired by the neuroscience of the day. But much of the relevant neuroscience of the past has been revised so significantly it might as well be replaced. We used to think that the brain was delineated into functional regions, with strong domain-specific differences between them, even suggesting that a single cortical column encodes something as specific as a visual edge with a specific orientation ([Horton & Adams, 2005](https://pmc.ncbi.nlm.nih.gov/articles/PMC1569491/)). Nowadays we regularly interpret brain behavior through the lens of statistics and complexity theory and we accept that macro-scale functionality is almost always the result of complex interactions spanning most of the brain. Neuroscience gave rise to the humble Perceptron, which eventually gave rise to Deep Learning. Along the way Neuroscience and Machine Learning have each evolved significantly, but independently.

Today, there is very little that relates ML to real Neuroscience. This is the case across the board. From the structure of the individual neuron (ANN vs spiking), to the learning algorithm (back-prop vs an ever-growing list of biological theories), to their macro-scale capabilities, strengths, and weaknesses.

If we are going to continue to learn from the brain, the ML industry needs to continue to pay attention to what’s happening in Neuroscience, Psychology, Behavioral Science, and Developmental Science.

## On System I and System II Thinking

While we’re talking about Neuroscience, let’s talk about cognition.

LeCun compares his model-free policy-based mode-1 style of JEPA operation with Daniel Kahneman’s System I thinking, and the search-based planning mode-2 style of JEPA operation with System II thinking. This is a mistake …. but he’s among many others who’ve made this same mistake.

There are two key factors, that distinguish System I from System II thinking: assumed implementation, and conscious access.

![](https://miro.medium.com/v2/resize:fit:1388/format:webp/1*qZOxkQpD-Ly0T6N094e4nA.png)

Distinctions between System I and System II

The mistake comes from drawing premature conclusions about the implementation underlying these two systems and then assuming that there is one-to-one mapping between these presumed implementations and the System labelling.

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*mOsxVWY_qQtZHGuxvxF6-Q.png)

Modes of action control (source: Author)

System I thinking is often compared to so-called model-free policy networks. These take an input, perform a single pass through a more-or-less feedforward network (may include some recurrency, but behaves as a feedforward network at the macro level), and produce a single output — the action or decision taken.

In contrast, System II thinking is often compared to model-based search algorithms (eg: JEPA’s mode-2). Here, recurrency happens at the macro scale. An overarching control algorithm runs the network many times with varying inputs to search for a sequence of actions that maximize the objective. This is a broad category of search algorithm known as Model Predictive Control (MPC), and it has many implementation variations in AI. Gradient-based search, beam search, graph search, DP, MCTS, were all mentioned by LeCun. All have the common characteristic that they are hand-rolled by humans and are hard-wired. The model is either learned or collected from prior known data. The fundamentals of how the search is performed are not learned.

I this point I find it useful to play out a thought exercise that starts with this question: if this were a biological organism, what would the algorithm look like? The biological equivalent of a hard-wired, hand-rolled algorithm is pre-configuration of brain structures through evolution. There’s a lot of controversy over the extent of evolutionarily defined pre-configuration (*a la* functional organization) in the brain, or whether everything is just learned from experience. But, what is clear, is that there is at least some pre-configuration — otherwise a dog could learn to read Dostoevsky. That pre-configuration then interacts with the learning process and life experiences. Notice that some fundamental facts about the environment are uniform across the entire planet (eg: the sky is up, water falls down). A logical extension is that some instances of pre-configuration + environment + learning results in extreme uniformity of some low-level brain processes across the species. In effect, some learned brain processes might as well be considered hard-wired. The point is that “hard-wired” has a place in biology, and so it is plausible for something akin to the Model Predictive Control algorithm to be effectively hard-wired. We can learn the model from experience, but the way that the brain uses the model depends primarily on our DNA.

But, what if planning could be learned?

To think about that, we need to first understand a concept that I call a “stochastically deterministic process”. The intuition is this: that some processes (aka algorithms) will always produce the same outcome for a given input, within some inconsequential level of stochastic noise. A simple feed-forward model is a classic example, but planning algorithms under simple conditions will also behave the same way. For example, when asked to pick up a cup that you have never previously touched, from a table that you have never previously interacted with, your brain almost certainly performs a model-based control to plan out the sequence. But anyone with knowledge of human gait and the appropriate software could easily predict the motion of your arm. My point is that while model-based planning is likely used to control the arm motion in this pseudo-novel situation, the amount of information that needs to be called upon to do the planning is minimal, and the level of uncertainty in planning algorithm execution is minimal. The process is effectively deterministic — it just uses recurrency to achieve that outcome. For example, this kind of stochastically deterministic planning is implicit in the ideas of Hierarchical Predictive Coding.

In contrast, more complex situations are not stochastically deterministic. Firstly, they involve information obtained and processed from all regions of the brain. Secondly, they may be fundamentally chaotic and need to be constantly monitored and corrected. Here I’m not talking about the autonomous micro-level monitoring and adjustment that happen while your arm is in motion. I’m talking about active conscious monitoring because anything might and will go wrong, or because there is insufficient prior knowledge about the circumstances to accurately predict the outcome.

And there we have it — I’ve just made reference to *consciousness*. My definition of “stochastically deterministic” vs not is still a work in progress. So since we’re here now, let’s continue.

While there is much guesswork about the underlying implementational differences between System I and System II thinking, a more obvious distinction is that for some processes we have *conscious access* (in the case of System II), while for others we do not (System I). Conscious access is a somewhat tautological term that means that we are consciously aware of that information. There are many and a growing list of things our brain does that we are not conscious of ([Oakley & Halligan, 2017](https://doi.org/10.3389/fpsyg.2017.01924)). The planning needed to pick up that novel cup is an example. There is no agreement on why there is a difference, neither from a neuroscience point of view, nor from an evolutionary point of view. The distinction is presumably linked to those implementational differences that we are fundamentally unclear about.

I believe that part of the distinction lies between those stochastically deterministic processes and the more complex ones. A stochastically deterministic process: a) doesn’t need to engage the whole brain to feed information into it, b) can be performed accurately and efficiently via only a small region of the brain, and c) doesn’t need to be actively monitored by all the superior monitoring capabilities that can be availed from the whole brain. This I suggest is the reason why most of our brain processes are System I and have no associated conscious access — they are too easy to need conscious monitoring. System II thinking is for the hard problems. It engages large parts of the brain to work on one problem at a time, they all feed information into the processing of the problem at hand, and they all then monitor the process itself and its outcome, ready to step in if anything goes awry.

Notice that uncertainty has a big part to play in System II thinking. You can see this in the way that System I processes can suddenly become System II processes if something unexpected happens.

I raised a question earlier about whether planning could be learned. There is another fundamental reason for the distinction between System I and II planning. As discussed, System I planning is essentially hard-wired. In ML, it amounts to making a fixed choice over gradient-based search, beam search, etc. That works well for certain domain-specific situations that are experienced regularly throughout life, particularly on the day-to-day scale. I suspect that such planning is indeed domain-specific in the brain, with a level of functional organization, and with the possibility for independent parallel execution of planning routines across differing domains — contradicting the assumptions made by LeCun. But more complex planning in novel situations requires a more adaptive approach — it requires us to learn how to plan.

AI research knows that there are many ways to search. There is greedy search, breadth-first search, depth-first search, heuristic search. Likewise, many varieties have been attempted on the basic idea of MPC. That’s planning. In many ways, *reasoning* can be likened to planning. But there may be many other possible variations there too.

The brain is amazing at learning all sorts of things. It constantly confounds me that the literature has never caught onto the idea that the brain learns the planning algorithm, the search algorithm, the reasoning algorithm. This I believe is the real heart of System II thought. It is planning/searching/reasoning where the world-model, the cost function, and the control algorithm are all learned. If we could build such a thing in ML it would be truly amazing. But keep in mind one major problem — such a system would be extremely unstable on its own. Every part of it is up for change over time. Such a system needs a powerful tool for maintaining stability. I won’t go into details here about how I believe it is possible to stabilize such a system. That is the topic of Meta-Management. I discuss elsewhere how I believe consciousness evolved as a very specific kind of meta-management architecture for the purpose of stabilizing System II thought:

## [Consciousness is a WHAT kind of loop?](https://malcolmlett.medium.com/consciousness-is-a-what-kind-of-loop-b0a2a637ebb9?source=post_page-----fabe5783134e---------------------------------------)

### The new theory that explains the what, why, and how of consciousness as a computational meta-management process

malcolmlett.medium.com

In summary, both modes of JEPA relate to System I thought. One operates as a feedforward model-free policy agent, while the other operates as the model-prediction component within the context of recurrent model-based planning. Both are “stochastically deterministic” — they have stable behavior even without any external “controller”. System II thought is something new, where the planning algorithm itself is learned, and which requires a new kind of algorithmic processing structure to ensure that it remains stable.

![](https://miro.medium.com/v2/resize:fit:1384/format:webp/1*YZW01sYmhH_fNKB7g1TyeQ.png)

Revised table of System I vs System II distinctions

LeCun’s mention of a “controller” module *could* be related to System II, but in practice, any working implementation that anyone comes up with any time soon is unlikely to mimic System II thinking until the academics realize the importance and challenges of learning the planning algorithm.

## On Abstract Representations

In some ways, JEPA is not much different from the major foundational models of the day work — they are trained to predict what their inputs would have been had it not been for some added source of ambiguity (masking, noise, different viewing angles, etc.). What JEPA does is to shift everything into a higher-order (lower dimensionality) abstract representational space.

This is known to have many advantages. For example, real-world raw perceptional representations have a high degree of covariance between inputs. Many of our methods for statistical reasoning make i.i.d. assumptions that aren’t true for raw perceptional representations. However, abstract representations can be far more i.i.d. I’ve seen a theory that the earliest stages of vision processing in the brain do just that; and we know how to add regularization in ML to achieve that gain (the VICReg method described by LeCun is an example). Secondly, it can be shown mathematically that working against lower-dimensional abstract representations can be just as accurate or even more accurate than working against raw observational representations, while being orders of magnitude more efficient (I once saw a brilliant explanation in one of Friston’s papers, but I’ve lost track of it; if anyone knows which paper that is please tell me \[UPDATE: [Rigoli et al, 2017](https://org.com/10.3389/fpsyg.2017.00408)\]).

This is exactly what we see with JEPA. As LeCun points out, dimensionality reduction plus regularization means that it necessarily avoids representing unpredictable noise, which has the effect of focusing on components with more *utilit* y for prediction.

But is JEPA fundamentally different from the approach today?

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*fok9eCeoGToyJMBw69XF4g.png)

(source: unknown)

In the current common encoder-decoder architectures (eg: a transformer), you have your original X input that passes through an encoder, that feeds to a decoder, that then produces its output Y that is either in the same state space as X or can be directly converted to it (eg: classification probabilities used to sample Y values). It is commonly assumed that the inner layers produce an abstract representation in “latent space” (more on that below) and that the decoder mostly operates against that abstract representation. This is even more explicit in multi-modal models that must necessarily use an internal representation that is distinctly different from at least all but one of its input modalities.

Now, according to the I-JEPA and V-JEPA papers, the foundational JEPA models are being trained against Sy (the abstract representation) rather than Y. And while it’s ultimately being used to generate a Y in those cases, the last decoder (Sy to Y) is merely an extra add-on that is trained separately.

Nevertheless, I think it’s misleading to say that JEPA builds an abstract representation any more so than any other encoder/decoder architecture. Given that fact, JEPA is not necessarily any different from other encoder/decoder architectures in terms of their ability to learn world models — to learn an internal representation of the relationships between natural components of the environment.

But, there are real differences and benefits to the JEPA approach.

The first is that the loss function (against the foundational model) operates against abstract representation space. This may be a bigger breakthrough than seems obvious at first glance. LeCun talks about the fact that loss functions in current-day encoder/decoder architectures operate against perceptual state space and thus they are trained against even the unpredictable fine details. This is only a good thing if you want pixel-level photo-realism. It’s bad at any other time. It places a disproportionate amount of training effort onto modeling that noise — disproportionate in relation to how much we *care*. We want the model to learn the big picture, to focus on the basic facts of life (eg: that hands usually have 5 fingers) over the fine details (eg: getting the appearance of the nail absolutely perfect, on a 6th finger). In the context of learning world models, having the loss function operating against abstract representation space, without inappropriate fine-grained influences from the target presentation modality, may prove to be a major leap forward. Less is more.

A second big improvement with JEPA is that it incorporates the explicit representation of a manipulatable latent variable. While the typical encoder/decoder network internally operates against abstract representations, it cannot experiment with different interpretations before drawing a final conclusion and passing that to its decoder. The latent variable will enable some very interesting things — once people figure out how to drive it.

And while we’re on the topic of latent variables….

## On Latent Variables

The term “latent variable” comes from statistics, and it is used particularly in Bayesian statistics. It refers to some property or state that we cannot directly observe. Thus it must be inferred from those observations. In practice, we often never know the structural nature of the true latent variables, let alone their states. So, in our modeling effort, we merely *assume* that our chosen latent variables are *sufficient* models of reality. Bayesian Networks are an example of trying to dynamically determine and adjust (ie: learn) our estimate of the structure of those latent variables. The chosen (estimated) structure of latent variables becomes the latent state space. To be even clearer, we usually refer to this as a *representation*, because it isn’t the true latent state, it merely *represents* it. There is some ultimately unknown and potentially unknowable isomorphism between the representation and reality.

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*xXLcD4KimNTqgeUXhSQMuA.png)

Prediction vs Inference (source: Author)

Once the latent state space has been chosen, the act of estimating the state of the latent variables, or rather the representation thereof, from observations is known as *inference*. *Prediction*, on the other hand, is a much simpler process. In prediction, we merely try to estimate the outcome of some process without trying to understand or model it. Estimating the latent state is extremely useful because, while it can be used to predict the outcome of the process, it can also be used to do other things — like predicting a future value of the observable.

When examining the function of perception in the brain we now understand that the brain does not perceive the world as it is. Rather, the brain makes observations of the world via the senses, and from that it constructs a representation of the outside world, ie: in latent space. The structure of that latent space is assumed to bear some relationship to the real world, but optimized for utility rather than for accuracy ([Hoffman et al, 2015](https://doi.org/10.3758/s13423-015-0890-8)). The observations of the world are informationally impoverished — containing a tiny fraction of the dimensionality of the real world. For example, a few thousand neurons fire because of light falling on them after reflecting off a rock in the distance. This carries virtually no information about the rock when compared to the rock’s inherent informational content (ie: its physical structure and makeup).

In that context, all Encoder/Decoder architectures follow a pattern of receiving an observable, inferring the latent state representation, and finally predicting some output from the latent state. JEPA is no different. Its encoder component performs inference, producing a latent state representation, which is then used for other things.

This fact can make the phrasing used by LeCun confusing. He introduces a latent variable *z* and says that is inferred through a minimization process separate from the initial encoder process into representational space. One may immediately ask why *z* is somehow treated any different from the rest of the inference of representational state. This confused me for a while too.

The explanation is in the specifics here: “The latent variable can be seen as parameterizing the set of possible relationships between an x and a set of compatible y. Latent variables represent information about y that cannot be extracted from x.” (LeCun, 2022). In other words, LeCun uses *z* not for the latent state of *x* alone, or of *y*, but as a representation of the *relationship* between *x* and *y*.

The lesson here is that JEPA is fundamentally designed as a “contrastive model” (or a “siamese network”), even though we want to avoid training it under “contrastive learning”. It is a “contrastive model” in that it’s designed to compare two inputs, or to learn relationships between pairs of inputs. This raises questions of how it could be used operationally when we only have a single input — eg: for image classification or generation.

There are three broad options available:

1. Drop the *z* term altogether. For those architectures where it doesn’t make sense, this will prove to be the easiest approach.
2. Pick a single *z* value based on some other external knowledge. One way to achieve this is if the *z* value has an easily interpretable meaning, such as by being hand-crafted. This is what they did for I-JEPA. They use JEPA as part of a transformer architecture against image patches, rather than the whole image. The transformer is fed several context patches from an existing image, and the *z* parameter determines the relative location of a patch that is omitting information and which needs to be filled in. In this case, the *z* parameter encodes the spatial relationship between patches in a human-meaningful way.
3. Marginalize over the distribution of *z*. In practice, computational constraints would mean that this would involve sampling a small number of possible *z* values, and then executing the predictor component against each sampled *z*. The final result could be a weighted sum, or it could invoke some additional measure of optimality to pick the best single result. The variance across the results could also be used as a measure of uncertainty.

## On Generative Processes

I’ve always struggled with the term “generative” in ML. A regression model “generates” a prediction of *y* given *x*, doesn’t it? A classification model “generates” a prediction of class given *x*, right? Notice the use of prediction too. These models “generate” predictions. A LLM is just a classifier (across words in a dictionary) that is executed many times. What makes it any more generative?

![](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*FoIVbc3pXdUS6UCjvCcJ-A.png)

Generative Process in Statistics (source: Author)

In statistics, a *generative process* is a system of interest that produces observable outcomes according to some (unobservable) latent conditionals (latent variables), and you wish to model it. As I mentioned in the prior section, we then tend to do either prediction, or we do inference under the assumptions of our model. Prediction is the task of estimating what the generative process is most likely to generate: for example, the clock will chime on the next hour. Inference is the task of estimating its internal state based on our observations: for example, the clock must be sitting on an hour because we’ve just heard it chime.

So an LLM infers the latent state of the meaning of a prompt input, and then predicts the distribution over the range of possible next tokens. And apparently that is generative, while a classifier is not. It turns out that, despite ML taking so much inspiration from statistics, its use of “generative” has nothing to do with the statistical generative process.

## Get Malcolm Lett’s stories in your inbox

Join Medium for free to get updates from this writer.

To understand, you have to go back to GANs — Generative Adversarial Networks. These were probably the first successful attempts to *create* images. Up until that point we’d classified them, detected objects in them, localized objects in them, and even modified existing images (eg: U-Net). But we’d never had networks create images from scratch, or create completely different kinds of images from another. Thus these ne models were called *generative*.

So what does modern-day ML mean by the term generative?

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*WOs6XP_0WJcxjs7yAkDR5Q.png)

Non-generative vs Generative models (source: Author). X and Y refer to the entire spaces of possible values.

If you look online, you’ll likely find a definition something like this:

- *Generative model: n. machine learning model that learns to generate new data samples that are similar to the samples they are trained on.*

And you might find that in contrast to, say, *discriminative models* such as for classification. So, in the non-generative model in the diagram above, X refers to the space of all possible inputs, and Y refers to the space of all possible outputs, and they don’t overlap. In contrast, generative models produce outputs in the same space as their inputs.

That’s helpful. Let’s apply this theory to two common models a classifier (the stereotypical discriminative model) and an LLM (the current stereotype of a generative model):

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*fDVuUZ-QOkvWpi_Jl-vGYA.png)

A discriminative and a generative model — both actually discriminative (source: Author)

The image classifier takes an input in the space of images and produces an output in the space of class-probabilities. An LLM takes an input in the space of sequences of embedded token vectors (represented in the diagram above as E###) and produces an output in the space of token-probabilities. Oh no. Viewed this way, an LLM looks a lot like another classifier. And it really, truly is. An LLM is trained to predict the next most likely token, given the current sequence.

But to make sense of LLMs as generative we have to think about how they’re *used*. An LLM is not just a neural network. It’s only ever used in combination with a bunch of human-written logic that wraps around it. Something I shall refer to here as the Model Execution Process (MEP). This is true of the image classifier, too, where the MEP typically takes the list of probabilities, picks the single highest value, and outputs the class associated with that probability. The MEP of an LLM is even more complex still. It again follows a similar pattern and picks the class (oops, I mean the token) with the highest probability then repeatedly executes the decoder part of the model to generate a whole sequence of output tokens.

When viewed in the context of the MEP, we can see how a classifier is different to an LLM, and how the classifier produces results in a different space to its inputs, while the LLM outputs in the same space as its input.

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*D3fqi1ktF2n5vzaROgiK6Q.png)

Discriminative and generative models in their native habitat (source: Author)

LeCun makes a big deal of the claim that JEPA is not generative. He’s been all over the internet claiming that “the future is not generative” (LeCun, many headlines). Let’s put that to the test.

The I-JEPA paper pre-trains a JEPA model in a self-supervised way according to the non-generative approach outlined by LeCun. However, JEPA outputs in abstract representational space, which is meaningless to anything other than the model. So, for demonstration purposes, they also train a decoder model that converts that abstract representation into an image patch. The MEP in this case runs the set of models multiple times to fill-in each of the missing patches in the input image.

Below is the same diagram as before, with the classifier and LLM, but now I’ve added JEPA with its execution process:

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*xgWmRf8nI-co_gN58HBU5Q.png)

A discriminative architecture and two generative architectures (source: Author)

In that context, JEPA seems very much generative.

So what to make of all that? Is JEPA generative or not? Have we got the definition wrong? Maybe it’s about how you *train* the model, rather than how you *use* it?

The ultimate lesson for me is that sometimes we end up with terms that are not ideal. They become part of our day-to-day technical jargon as a result of a history that is eventually forgotten. We use the terms comfortably because we intuitively understand what they are meant to mean. And, intuitively, an LLM is generative because it outputs samples of the same type that it was trained on, whereas the JEPA architecture is specifically trying to step away from that raw real-world sample space and move to latent space, where we can gain some important advantages. The intent is clear. I expect we will continue to use the “generative” term for the former, and avoid it for the latter, because that’s what we’ve been told to do.

But more, I think this confusion belies something more fundamental. LeCun started his 2022 paper with the idea of moving towards predictive world-modeling. I don’t think JEPA hits the mark.

For that, we need something more like Predictive Coding…

## JEPA and Predictive Coding

I’ve long been a fan of the Predictive Coding (PC) interpretation of brain function and I’ve long wondered why we haven’t managed to incorporate its natural flexibility into ML design. Thankfully, while writing this article, I’ve now discovered that it is indeed beginning to make progress ([van Zwol et al, 2024](https://arxiv.org/abs/2407.04117v1)). JEPA feels very closely related to PC, but LeCun doesn’t take much time to draw out their relationship or their distinctions.

PC applies a Bayesian perspective to understand how the brain processes information ([Millidge et al, 2021](https://doi.org/10.48550/arXiv.2107.12979)). It uses probabilistic models of the world and a process of prediction error minimization for both perception and learning. That error minimization process results in an inferred representation of the latent state of whatever is being observed. It is also hierarchical, and so the latent state is represented across many different granularities, with the most abstract and most complete at the top.

![](https://miro.medium.com/v2/resize:fit:1112/format:webp/1*jJCzOCsjPCR1kpjuicdClQ.png)

Hierarchical Predictive Coding (source: Author)

It starts with some sensory input being encoded as a representation at the lowest level of granularity (R₂). This leads to an inference of the latent state at the next higher level of granularity (R₁), and repeating up the layers until it reaches the most abstract representation (R₀). Both those initial guesses are likely to contain errors — which we call hallucinations in current ML. The multi-layer system also embeds a world model, which enables it to predict the most likely sensory input given a latent state. This starts from the top. From R₀ it predicts an estimate of R₁ and then uses the prediction error to revise R₀. At the same time it uses a combination of R₁ plus that prior prediction error to predict an estimate of R₂. That is used to produce a prediction error which is then used to revise the inference of R₁. The details get far more involved, which I’ll completely gloss over here.

This is an inherently recurrent network that results in oscillations of activity (observed in the brain as EEG) and ultimately carries out something akin to Maximum Likelihood Estimation. In some models the initial upward inference step is dropped. It turns out that the same outcome can be achieved by allowing the representations at each level to be initialized to white noise, or to just whatever state they were before. The error signals alone are sufficient for the system to converge. This has been shown to produce something called “efficient coding”, also referenced by LeCun.

In PC, inference is an iterative process that takes three inputs (a) the raw sensory observation, (b) a previously estimated latent state, and (c) a world model. The world model is encoded in the learned weights of the network and its hierarchical structure. The previously estimated latent state is represented in the initial conditioning of representations at each layer. The raw sensory observations arrive at the bottom and, through error propagation, cause the representations to converge towards the new latent state that best explains the observations, conditioned on the prior state and the world model.

![](https://miro.medium.com/v2/resize:fit:1376/format:webp/1*xwh8RmNdBXT3eCigx4LJQA.png)

Single JEPA layer (source: Author)

On the face of it, hierarchical JEPA does something very similar. It also uses world models for prediction. It also could support iterative inference through its use of the *z* latent variable. At first I was hopeful that JEPA could efficiently emulate PC. However, upon further inspection I realised that they very different models after-all.

The point of PC is to operate against a moment-to-moment sensory input and to infer the latent state of the world from that input. It’s extremely flexible, and can easily support multi-modalities, and to operate across sequences. JEPA, however, is designed as what I’d call a “contrastive model” — it depends on having a second input in order to measure the error necessary for its inference process. Without the second input, it appears more like a well-trained and well-optimized feedforward network. It’s not obvious where you’d get the *z* from, aside from prior conditioning.

![](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*4qg97YOqPQMzKZ_rsYouSQ.png)

JEPA for Predictive Coding — not really Predictive Coding (source: Author)

It’s that last thought that gives one idea of how JEPA could be of benefit in the context of PC. It provides a natural way of combining moments across time to better infer aspects of the latent state that cannot be inferred from a single moment in time. The example above uses vanilla JEPA against adjacent (or nearby) timesteps in sequence data, and uses it to infer *z* as an extra component of the latent state present in *x* — namely: motion.

However, JEPAs proposed methodology for hierarchical layering does not seem compatible with that of PC. Intuitively one would expect that the higher layer would somehow feed the *z* value for the layer below. But it’s not clear how to make this happen.

## On Energy Based Models

Most current day models are probabilistic — mean that their outputs are interpreted as probabilities. Binary classification and logistic regression are classic examples.

There’s no reason why the model has to produce probabilities, but we find it convenient because of it’s implicit regularization. It’s natural to normalize the outputs of a logistic regression model via softmax, so that the outputs fall into a range that we have experience with and thus can understand intuitively. But more importantly, probability outputs make it easy to define the loss function — there’s only one way to represent the correct answer.

EBMs are basically the same structure, but they drop the inherent or explicit normalization. Now there’s no absolute interpretation, only a relative interpretation — that some result has a higher energy than another. This naturally leads to contrastive training methods, when you run the model against a pair of samples and train it such that one has a higher energy than the other.

There’s two major problems with this. First, the asymptotic complexity of preparing the training data set goes from O(N) to O(N²). Now not only do you have to extract/devise and label so many samples, now you have to do that for many *pairs* of samples. But more importantly, it becomes an order of magnitude harder to get sufficient coverage of the search space.

Secondly, your loss function is based on the *sign* of the difference between predictions on the two inputs, ignoring the magnitude (though I think there people have ways to incorporate the magnitude).

LeCun says that the biggest problems with probabilistic models is that they don’t scale to large output domains and that they don’t work well for continuous spaces. For example, current LLMs still work by outputting a probability distribution over all possible tokens. For simple text modalities, that’s the set of all possible 2- or 3-letter tokens. But for image and audio modalities you’ve got problems. Effectively, the probability distribution representation places a limit on the *precision* to which an LLM can represent its final output.

LeCun says that we need to switch to EBMs and learn how to control them. For that he recommends something called VICReg as a starting point — which applies a combination of regularizations plus prediction error for training. VICReg stands for “Variance, Invariance, Covariance Regularization”.

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ENBJYSrsyUnL95I_ctcM4A.png)

VICReg regularization in JEPA training (source: LeCun, 2022)

The high-level idea behind the regularization is to 1) maximize the mutual information between the inputs and outputs of the encoder components, and 2) minimize the information content of z. But the maths behind mutual information is hard. The equation for the mutual information, I(X;Y), between two variables, X and Y, require that you calculate or approximate the famous Kullback-Leibler divergence:

![](https://miro.medium.com/v2/resize:fit:1100/format:webp/0*r8f2mhvKeMxl9qCX)

Worse, computing the mutual information often gets computationally expensive. Here’s an example formula for two discrete random variables X, and Y, for which you know the joint probabilities (from the Wikipedia article on [Mutual Information](https://en.wikipedia.org/wiki/Mutual_information)):

![](https://miro.medium.com/v2/resize:fit:1100/format:webp/0*LajznSIKBq55xe2f)

I like the idea of mutual information — as a concept — but I dread having to calculate it. VICReg makes some simplifying assumptions that results in a strategy that is easy to calculate and computationally efficient if applied on a per-batch basis. Two of its basic components Variance, and Covariance, simply require you to build a covariance matrix between your two variables — in this case the pre- and post-encoder values, *x* and *Sx*. The variance is computed off the diagonal, and the covariance off the whole matrix. The somewhat clumsily named Invariance part is just your usual prediction error, such as via an L2-norm.

With that, we have a way of reigning in the extra degrees of freedom afforded by EBMs, so that they build representations that hopefully have high utility. All regularization schemes have their disadvantages, so there’s also the risk that we end up with a model that is much harder to train than our tried-and-tested prodabilities models. On the other hand, I keep seeing suggestions that the brain employs similar mutual-information minimizing/maximizing strategies, so perhaps this really will be the way forward.

It’s going to be interesting to watch this space.

## On End-to-End Training

Before I wrap up, I’ll return briefly to the big picture.

In ML there has always been a conflict between *structural approaches* (leveraging human domain knowledge in designing solution architectures) and *scale* (approaches that leverage fundamental general-purpose ideas of learning and then just scale them up with more data, eschewing anything domain-specific).

The claim for scale can be seen in [*Reward is Enough*](https://doi.org/10.1016/j.artint.2021.103535) (Silver et al, 2021) and in the [*Bitter Lesson*](http://www.incompleteideas.net/IncIdeas/BitterLesson.html) opinion piece by Silver’s mentor (Sutton, 2019). LeCun takes the opposite stance and claims reward is not enough. He seems to intend this as a general statement but is careful to restrict his explicit statements to the domain of self-supervised learning, where the only source of training loss is prediction error. To get a feel of how heated and confusing this debate can be, take a look at [this Reddit post under r/MachineLearning](https://www.reddit.com/r/MachineLearning/comments/wyqyu8/d_a_thought_i_had_on_yann_lecuns_recent_paper_a/).

LeCun’s case against rewards is exemplified very artfully in Dawid and LeCun (2023) in the metaphor of a cake:

![](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*sBYRYM-2vxvA-_G5Jzvx8Q.png)

Cake metaphor of learning approaches (source: Dawad & LeCun, 2023)

From this metaphor we have:

- (SSL) Self-supervised learning gives you information from the main content of the cake, which is orders of magnitude more in quantity than anything else.
- (SL) Supervised learning gives you information from only the icing covering the outside of the cake
- (RL) Reinforcement Learning trains via only the cherry on top.

There’s a few things going on here.

In both supervised and RL training there is always a training signal (aka loss) that is computed based on the output of the network and then used to propagate weight updates throughout that network. They are called different things (loss, prediction error, reward) and subject to slightly different constraints, but they are effectively the same thing. In both cases it is a scalar value, that is transformed into a loss, and then minimized through training. And yet, those constraints have an important effect. Supervised learning provides a training signal per sample, where each sample is independent. The training signal in RL can only be interpreted over an ordered sequence of samples (aka the *trajectory*). If you take that the scalar training signal has some degree of informational content, in the RL setting it has a fraction of what it would have for SL, proportional to the inverse of the length of the sequence. What’s more, the length of that sequence is usually non-deterministic and heuristics are employed, leading to further inaccuracies in the training signal. This logic can be extended to consider SSL. Conceptually, SSL generates a full and detailed output (eg: an image), and the training signal is calculated across every component of that output (eg: pixels) — ie: the whole cake. However, in practice, we don’t do that. Instead, we find it necessary to define a way to declare the relative strengths of each per-component error, and we do this by defining an equation that collapses the result to a scalar. This is exactly what we’ve always done for SL and RL. Thus, SSL is no different from SL or RL. They all train off a scalar training signal. And SL/SSL are completely identical.

The more fundamental difference is the ease of obtaining training samples. SL requires pre-labeled data. For productive results the vast majority of training data must labeled by the best reference point we have — which is currently still humans, thankfully. While RL doesn’t require any pre-labeling, the collection of training samples requires running the RL agent through a training environment. Even when using a simulated environment this is still orders of magnitude more computationally expensive than for SL. SSL allows you to take raw data and train directly from it without pre-labelling. That’s the real win.

Ultimately, when viewed from the point of view of scaling laws, there are no paradigmatic differences between RL, SL, or SSL. They are the same learning paradigm, with different constraints imposed by the different ways of obtaining training data and the training signal. Most importantly, they have different scaling factors — with SSL scaling far higher than the others.

The last point to make here is not about the differences in SSL, SL, or RL, but in the structure of *where* the training signals are applied. Most ML today applies a single loss to the final output of the network. This is the goal of end-to-end training. While we make use of micro-scale non-linearities within networks, we find that back-prop only works if the network operates within a sort of “linear region” at the macro-scale. We apply initialization schemes and normalization to keep layer outputs within the -1... +1 range, with the aim of limiting the multiplicative effects across the layers to approximately scale to 1.0. Problems of vanishing gradients were solved by shifting to activation functions like ReLU that behave at least pseudo-linearly for most of their range. There’s a lot of neuroscience literature that uses linear models to understand brain function. However, since LLMs have taken off I have seen an explosion in the amount of experimentation with different activation functions, and a lot of problems with instabilities (eg: discussed at length in relation to Transformers in a recent paper from Meta ([Chameleon Team, 2024)](https://arxiv.org/abs/2405.09818)). I think it’s a mistake to treat the model as a single end-to-end black box and only provide training signals to the output. In the Predictive Coding theory of brain function, the brain can be seen as many layers of hierarchical SSL processes, with each layer providing an error signal to the one before. Additionally, the brain is known to have many long-distance lateral connections, at least some of which likely provide error signals at different levels of abstraction. Such an approach should cope far better with non-linearities. Predictive Coding has not yet made a lot of progress in pure ML, but I have often thought that we should take a lesson from it by building our architectures as modules — with each module receiving part of its training signal from local SSL. JEPA may be a start toward that goal.

## Conclusions

I like JEPA. I think it has a lot going for it as an architecture, and I think it will be tremendously useful. But not for all the same reasons that LeCun says. I find it unfortunate that such a good idea has been introduced in a paper that contains so many inaccuracies, term misuses, and disingenuous comments about the existing architectures.

If I were to take a punt at describing JEPA, it would be something like this:

- JEPA is a *contrastive model* that can be used for prediction (with some caveats about how you engineer the meaning of *z*)
- being contrastive, it is suitable for self-supervised training via masking, which gives us a huge leg up in the problem of finding training sets
- it is also suitable for more natural contrastive problem domains such as face recognition
- it introduces a loss mechanism that unshackles us from the constraints of the probabilistic output domain
- it applies the prediction-error loss against the abstract representation space, which should a) significantly improve its tolerance to noise, and b) enable it to infer latent representations that are simultaneously more compact and more useful than those inferred by our current encoder/decoder architectures.

Phrased that way, JEPA avoids being marketed as something that it’s not, while still retaining a lot of potential. I look forward to what comes next.

## References

Assran, M., et al. (2023). Self-Supervised Learning from Images with a Joint-Embedding Predictive Architecture. CVPR 2023. [https://arxiv.org/abs/2301.08243](https://arxiv.org/abs/2301.08243)

Bardes, A., Garrido, Q., et al (2024). \[V-JEPA\] Revisiting Feature Prediction for Learning Visual Representations from Video. ArXiv. [https://arxiv.org/abs/2404.08471](https://arxiv.org/abs/2404.08471)

Chameleon Team, Meta Research (2024). Chameleon: Mixed-Modal Early-Fusion Foundation Models. ArXiv. [https://arxiv.org/abs/2405.09818](https://arxiv.org/abs/2405.09818)

Dawid, A., & LeCun, Y. (2023). Introduction to Latent Variable Energy-Based Models: A Path Towards Autonomous Machine Intelligence. ArXiv. [https://arxiv.org/abs/2306.02572](https://arxiv.org/abs/2306.02572)

Hoffman, D.D., Singh, M. & Prakash, C (2015). The Interface Theory of Perception. *Psychon Bull Rev,* **22**, 1480–1506. [https://doi.org/10.3758/s13423-015-0890-8](https://doi.org/10.3758/s13423-015-0890-8)

LeCun, Y. (2022). A Path Towards Autonomous Machine Intelligence. OpenReview. [https://openreview.net/pdf?id=BZ5a1r-kVsf](https://openreview.net/pdf?id=BZ5a1r-kVsf)

Millidge, B., Seth, A., Buckley, C. (2021). Predictive Coding: a Theoretical and Experimental Review. Computer Science. [https://doi.org/10.48550/arXiv.2107.12979](https://doi.org/10.48550/arXiv.2107.12979)

Oakley, D. A., & Halligan, P. W. (2017). Chasing the Rainbow: The Non-conscious Nature of Being. *Frontiers in Psychology*, 8, 1924. [https://doi.org/10.3389/fpsyg.2017.01924](https://doi.org/10.3389/fpsyg.2017.01924)

Rich Sutton (2019). Bitter Lesson. Blog post. [http://www.incompleteideas.net/IncIdeas/BitterLesson.html](http://www.incompleteideas.net/IncIdeas/BitterLesson.html)

Rigoli, F., Pezzulo, G., Dolan, R, & Friston, K. (2017) A Goal-Directed Bayesian Framework for Categorization. *Frontiers in Psychology*, 8, 408. [https://org.com/10.3389/fpsyg.2017.00408](https://org.com/10.3389/fpsyg.2017.00408)

Silver, D., Singh, S., et al (2021). Reward is Enough. Artificial Intelligence, 299:103535. [https://doi.org/10.1016/j.artint.2021.103535](https://doi.org/10.1016/j.artint.2021.103535)

Sloman, A. (2007). Why Some Machines May Need Qualia and How They Can Have Them: Including a Demanding New Turing Test for Robot Philosophers. In A. Chella & R. Manzotti (eds.), AI and Consciousness: Theoretical Foundations and Current Approaches AAAI Fall Symposium, Technical Report FS-07–01, pp. 9–16. [https://www.cs.bham.ac.uk/research/projects/cogaff/sloman-aaai-consciousness.pdf](https://www.cs.bham.ac.uk/research/projects/cogaff/sloman-aaai-consciousness.pdf)

van Zwol, B., Jefferson, R., & van den Broek, E. L. (2024). Predictive Coding Networks and Inference Learning: Tutorial and Survey. ArXiv. [https://arxiv.org/abs/2407.04117v1](https://arxiv.org/abs/2407.04117v1)