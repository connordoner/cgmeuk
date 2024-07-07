---
date: 2024-07-07
status: accepted
---

# ADR 2: Work in the open

## Context

I've always been a supporter of open source in principle but have had the same
reservations as many others no doubt have—mostly around security, licensing,
and, above all, whether anyone will actually care about what I'm building or how
it works (I'm not on the verge of being a nihilist these days for nothing!).

However, I've very little to lose by defaulting to open-sourcing my code, and
potentially a lot to gain by joining a community of like-minded people.

I also like the fact that, as someone who's always been insatiably curious,
those like me might find answers to how my personal website works at the source
(if you'll pardon the atrocious pun!).

## Decision

I'm going to default to open-sourcing the content and assets,
infrastructure-as-code definitions and documentation that make up my personal
website.

The only time that I won't do this will be when doing so would be detrimental to
security or would breach a legal contract that I'm party to (such as a license).

## Consequences

Any passwords or secrets that I accidentally publish, such as API keys, are
likely to be the victim of compromise almost immediately. I'll mitigate this by
enabling GitHub's [secret scanning feature][secretscanning].

I also anticipate that I'll receive a small number of external contributions to
my personal website which I wouldn't receive otherwise. Now that I have more
free time, I'll be easily able to handle the volume that I anticipate.

[secretscanning]: https://docs.github.com/en/code-security/secret-scanning
