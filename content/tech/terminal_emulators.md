---
date: '2026-04-30T18:55:24-05:00'
draft: false
title: 'Terminal Emulators: A Comparison'
categories: ["tech"]
tags: ["terminal", "tooling", "linux", "macos"]
description: "An examination of some of the many options for terminal emulation available today on linux and mac"
summary: "Dive into more terminals than you'll ever need (or should probably exist at all)."
showToc: true
---

## Forward

Before beginning this piece, I would like to acknowledge a few points.  I bring these up both to preempt criticism and allow the reader to understand where I am coming from, but I do not think they should be taken to diminish or discount any of the rest of this.

- It probably doesn't *really* matter what terminal emulator you choose.  The overwhelming majority of people using computers day to day, and even most developers, probably aren't using advanced features.  Even more,  those who are using advanced features probably already know their tool of choice so well that switching would end up costing them more time than it eventually saves.
- I am not in that .1% of roles where my choice of terminal emulator is critical to performance.  I could do all of my work on the default Konsole or Terminal.app easily enough, if I so chose.  I also don't "live in the terminal" as an object of philosophical fixation; I am just as happy to use a GUI app if it provides a better experience.  If that gives you pause in listening to me, be advised.
- There is more information here than 99% of users will ever want/need.  For the vast majority of readers, jumping to either the [minimalists](#the-minimalists) section or [superlatives](#the-superlatives) would be the best thing, depending on whether you are heavily resource constrained (or just a big fan of minimalism) or not.

## Terminals And Their Evaluation

There are a number of criteria on which you can evaluate a terminal emulator: Available platforms, included features, configurability, performance, UX, efficiency, and much more.  Common examples of this include a given terminal's support for various image protocols (iterm, sixel, and kitty), the amount of configuration options and their ease of use, the presence of a built in multiplexing solution, whether they are easily extendable through scripting, etc.  In this piece I will conversationally evaluate all of these things, but also include as much objective information as possible.  I will do this in part by listing the available platform(s) at the top of each section, and providing a set of benchmarks at the bottom.  For this I will use Alacritty's [vtebench tool](https://github.com/alacritty/vtebench/tree/master), the benchmarking "kitten" from kitty (when possible), and testing the terminal's start time Hyperfine on Linux (I have yet to find a good mac equivalent for the mac exclusive terminals).  The machine that I used to run most of these measurements on uses an Intel i7-12700KF CPU at 5.1Ghz, NVidia 3080Ti GPU, 48GB DDR5 RAM, and a 2TB NVME SSD.  It runs NixOS for the Linux terminals.  For the Mac exclusive ones, I used a 2024 Macbook Pro with an M4 Pro Silicon chip and 24GB RAM.  I will make sure to test some of the cross platform options on the Macbook as well to ensure comparisons are reasonably fair.  All of these benchmarking comparisons were run using the latest version of these programs available on the unstable branch of nix packages (nixpkgs) on the weekend of April 11th, 2026, or the standard version available in homebrew (in MacOS).  Lastly, I will also include RAM utilized while idle.  I am not personally a huge believer in the utility of benchmarks in this regard (most terminals are fast enough and consume few enough resources that it won't really matter), and massive amounts of TTY throughput isn't necessarily reflective of how we might use them day to day, but they may be useful as a guideline for curious or resource-conscious users.  

## The Defaults

The following terminals are the ones you primarily use because they come preinstalled on your system.  That isn't to say that they are bad; entire careers have been conducted in Terminal.app, oftentimes by people making a lot more money than me.  What it means is that these terminals all share a handful of characteristics that users should keep in mind before committing to using or not using them.  These terminals are all relatively lightweight, tend to be a little lighter on the need for configuration, and are extremely unlikely to be abandoned by their developers (the benefit of first party tools).  However, they are also universally not GPU accelerated (read: a little slower), less customizable than some other options, and generally behind on cutting age features (usually a drawback to a first party tools).

### Konsole

Konsole is the terminal associated with the KDE Plasma desktop environment for Linux.  It is one of the best examples of the KDE philosophy ecosystem I can think of; maximal in terms of features, highly customizable (especially for an included terminal app), and altogether attractively designed.  As for downsides...there really aren't many.  The real "downsides" of Konsole are more about what it does *worse* than other options than about anything it does outright wrong.  It just isn't as performant (lacks hardware acceleration), configurable, or efficient as the options I would consider to be the very best, nor does it have any special integrations with the KDE environment that might especially motivate people on that DE to stick with it.  In my book, Konsole is a textbook example of "good, but not the best".  I cannot think of a real reason to recommend it to anyone over the very best options, but at the same time it is more than adequate, and could be most peoples' daily driver without issue.

[Link To Benchmarks](#konsole-emulator-benchmarks)

### xfce4-terminal

xfce4-terminal (xfce-term) is the terminal associated with the xfce Linux distribution, a distro known for being very lightweight and resource un-intensive, targeting older or weaker machines.  It is a common choice for those wishing to "resurrect" an old laptop that no longer has the horsepower to run the latest Windows (or heavier Linux distro) effectively.  The terminal, then is more or less exactly what one might expect.  It is very lightweight, consuming around 30MB of RAM for me whilst idle, among the very lowest of any options that I have tested.  It also starts up very quickly, the fastest of any options outside of the [Minimalists](#the-minimalists) section.  It actually *does* have image support through the sixel protocol, but does not support the Kitty image protocol or have any hardware acceleration.  Of any of the built-in, distro-specific terminals, I have to say this might be my choice for best executed in terms of achieving its goals.  As of 2026-04-06, xfce distro uses X11, and the primary competition xfce-term posses in the minimalist space there is against st-term.  While st-term is by no means bad, I cannot really say that it is necessarily *better* than xfce-term.  Indeed, I personally do not see the benefits of switching, and if I were on a very weak machine running the xfce distro, this would probably be my terminal of choice.

[Link To Benchmarks](#xfce4-term-emulator-benchmarks)

### Terminal.app

Terminal.app is the default Mac terminal, no doubt familiar to many, if not all readers.  It is also the terminal I have probably used the most of any in this piece, having used it for around a year somewhat heavily when I switched to using Mac OS for work.  Amusingly, as many other users can attest, a very significant portion of my use of Terminal.app was listening to other Mac users ask "Why don't you switch to iterm2?" This annoyed me at the time, as I wasn't particularly interested in bothering with various different terminals, but in retrospect it was a very legitimate question.  Terminal.app *is* configurable in terms of both settings and appearances, but really, it plays the little brother role to both iterm2 and other options in virtually every way.  It is less configurable, less performant, less beautiful, and similar in terms of resource consumption.  It isn't awful by any means, but unless absolute stability and desire to install no extra programs are your only real criteria, I don't really see much of a point to remaining with it.  Even for the most die-hard Apple enthusiasts, iterm2 out "Macs" this default Macintosh application.  Not recommended.

[Link To Benchmarks](#terminalapp-emulator-benchmarks)

### Ptyxis

Ptyxis is the terminal currently associated with the GNOME DE for Linux, and it appears as though it will be the terminal of choice for that platform moving forward.  For those unfamiliar, this is signficant because GNOME has gone through three terminals (that I know of) in its lifetime: GNOME Terminal (classic, minimalist terminal), GNOME Console (AKA kgx, an intended upgrade to GNOME Terminal that appears abandoned) and now Ptyxis.  Of all the terminals that come as defaults with the major Linux distros, this is among the most "modern", featuring GPU acceleration, highly active development, and a level of customizability really only rivaled by KDE Konsole in this "default Linux terminal" space.  Even more, it has a unique hook: the native integration of per-tab container oriented tools and environments.  Put simply, each Ptyxis instance (and each individual tab) can be associated with a given container, making switching between multiple containers (or opening new tabs within the same container) a breeze compared to other offerings.  While this is not particularly helpful to *my* personal workflow, I can absolutely see it being relevant to a great number of users.  I have to say: I am overall fairly impressed with Ptyxis, and I think it accomplishes what it sets out to do better than most, up there with [xfce4-terminal](xfce4-terminal) in terms of default terminals meeting their goals.

Best For:
- Users for whom switching containers is paramount
- Users very attached to the GNOME environment/toolset

[Link To Benchmarks](#ptyxis-emulator-benchmarks)

## The Curiosities

These terminals are, for whatever reason or another, not for me, and I do not recommend them.  However, that doesn't mean that I believe they are *bad*; Indeed, most of them have some kind of hook (thus the name) that might make them interesting to *you*.  Rather, I simply believe that either they possess drawbacks I am unwilling to tolerate or, are mostly or entirely outmoded by other offerings.

### Tabby

Please do not use Javascript to write your terminal emulator.  Just because you *can*, does not mean you *should*.

### Cool-Retro-Term (CRT)

CRT is an example of a terminal where I'm not sure if it's really *trying* to be a serious entry into the terminal space.  CRT is named as such because it attempts to mimic the appearance of a classic cathode ray tube (CRT) television.  In that, it succeeds with flying colors.  However, as a daily driver terminal, I am just not sure why you might actually use it.  It lacks any kind of image support, and while it is hardware accelerated, it still isn't as fast as a lot of other options.  It also lacks the extensive configurability of a lot of its peers.  Add that to the fact that the CRT aesthetic is actually much *harder* to read than standard terminal text, and I can only recommend if you value the retro aesthetic above all else.  Still, it may be worth an install just for the sake of having around to look cool.

[Link To Benchmarks](#cool-retro-term-emulator-benchmarks)

### Warp

Warp almost merited its own section.  It is a very unique case, and I have struggled to evaluate it in comparison to other options.  For those who may be unaware, Warp is a terminal focused on integrating LLMs/AI directly into the terminal experience.  It markets itself as "the agentic development environment", and pushes those features hard in all of its promotional material.  It is also worthy of note that Warp is a VC backed product rather than an open source project like the other terminals on this list.  This suggests it will likely have high development velocity, but also an elevated possibility of becoming abandonware in the feature, should the company not work out financially.  When using Warp for the first time, users are asked to...log in? A strange thing to be sure, but it makes sense for a platform focused on paid AI integration.  That being said, I will not pretend like it wasn't immediately off putting, and felt wrong in a space that is normally about the blooming of a thousand free flowers.  Ultimately, I decided for this piece to evaluate Warp with the AI features disabled, which is mercifully a very convenient toggle.  This may seem unfair as it effectively disables Warp's killer app, but at the same time AI integration is different than what the other options terminals are doing that I felt quality comparison with them on would be impossible.  With AI integration off, one major positive should be said for Warp: it's very pretty.  The default "Warpified" prompt is sleekly modern and attractive, and several of the built in backgrounds/color options look great.  It also comes bundled with a few majorly cool features.  The first of which the user is likely to notice is its "blocks": visual groupings for commands and their outputs, which are an appreciable boost to visual coherency.  Even cooler, these blocks can be shared with others using Warp.  It also has built in completions/suggestions that usually require shell configuration to get in the terminal, which isn't terribly useful to most veterans but is probably very nice for new users.  It even has its own built in IDE, which I personally question the utility of, but may be desirable for those looking to unify their workflow under one development platform.  Unfortunately, I do think that, despite all these positives, the bell ultimately tolls for Warp, because it gets a number of the basics wrong.  Firstly, all of these bells and whistles come at a cost, as Warp uses more than double (almost 600MB!) the amount of RAM of next hungriest terminal while idle.  Furthermore, despite being a heavily developed Rust project, it is slow, noticeably so compared to many other options (although it defied my attempts to apply several of the benchmarks).  It also lacks the configurability and extensibility of many of the best options in this space, despite presenting as a very maximalist choice.  With the AI off, Warp certainly has redeeming qualities, but I find it difficult to recommend in light of its shortcomings.  

[Link To Benchmarks](#warp-emulator-benchmarks)

### Contour

Contour is a terminal I found out about from a forum post by Wez Furlong, the creator of [WezTerm](wezterm).  Contour is a modern GPU accelerated terminal written in C++ focusing on performance, and in that it would appear to succeed.  Anecdotally, it is one of the snappier terminals I have used.  Less anecdotally, when using actual benchmarks, it lags well behind some of the frontrunners.  Still, it's performant to the point that it isn't really an issue, and has a solid look/feel.  That being said, I am unsure whether or not it really offers anything over other options to make it a solid choice.  This is an excellent example of terminal that doesn't really do anything *wrong* (except for some strange default keybinds), but at the same time doesn't do enough different/better to stand out from other options, at least in my humble opinion.  

[Link To Benchmarks](#contour-emulator-benchmarks)

## The Minimalists

Here we arrive at terminals that deliberately do less.  That suck less, in one case.  These terminals deliberately seek to keep things as simple and streamlined as possible, and should appeal to those who find most software bloated beyond any real purpose.  I am a big enough sucker for pretty lights and avant garde nonsense that daily driving these did not turn out to be for me, but I certainly see the appeal for a significant subset of users.

### Simple/Suckless Terminal (st)

st term in an interesting case: First of all, explaining the name:  It is a terminal by [suckless.org](https://suckless.org).  It is commonly referred to as "suckless terminal" colloquially, but seems to be called  simple terminal or "st" by its maintainers.  If you are familiar with suckless philosophy, you probably have a decent idea of what kind of software this is.  If not, a reasonable way of expressing it is to say that, in their minds, most software sucks because it does too much.  Simple terminal then is exactly what you would expect from such a group: the absolute most minimal terminal possible.  No hardware acceleration.  No image support.  Ligatures?  Scrollback? More like BLOAT (suckless adherents call *everything* bloat).  As a trade off for these things, you get simplicity and blazingfly fast startup times (65ms), second only to Foot.  That being said, I don't know if I really recommend it.  It doesn't beat xfce4-terminal by enough in any category to really push for it, and some of the things it deems bloat I would call basic quality of life, particularly scrollback.  

Best for:
- Those demanding the utmost (utleast?) minimalism on X11

[Link To Benchmarks](#st-emulator-benchmarks)

### Foot

Foot is a terminal emulator built for the Wayland DE on Linux that strives to have the smallest *foot*print possible.  Ha.  Puns aside, it does an incredible job.  It uses the single least amount of RAM of any terminal that I have seen (25MB for me whilst idle), a ridiculously small binary (<5MB), and has a startup time so fast that it borders on imperceptible: ~30ms normally, ~16.5ms when using its special client/server configuration, as though it needed to be even faster.  It also doesn't even totally eschew image support despite its minimalism.  Overall, I am a big fan of Foot, and if you are on a Wayland DE and want the fastest, lightest terminal available, look no further.

Best for:
- Users with extremely limited resources in terms of space/hardware power
- Usecases where startup time is paramount for one reason or another
- Fans of minimalism in general

[Link To Benchmarks](#foot-emulator-benchmarks)

## The Contenders

These are good-to-great terminal emulators.  They check all the major boxes, and I think deserve serious consideration from users.  While I don't recommend these *quite* as strongly as I might the superlatives, they are still strong offerings that you could spend your whole career with and be quite happy.

### Alacritty

Alacritty's influence and legacy in the realm of terminal emulators can scarcely be overstated.  It ushered in the modern era of GPU accelerated terminal emulators, and remains the gold standard for speed to this day.  In fact, its parser is used in many other terminals in the ecosystem.  It is rock solid, stable, and really all but beyond reproach in what it does.  Why, then, do I not give it the highest possible recommendation?  Because I think that in 2026 it exists in a bit of a no man's land.  It *is* very fast, but so are kitty and Ghostty, and both of those distantly outstrip it in terms of features.  It does have a minimal footprint compared to those...but if you want minimalism, Foot is *much* more minimal while also being fast at a lot of tasks.  If you're looking for a feature-light, midweight terminal that works at blistering speeds, Alacritty cannot be beat.  I simply question the size of the audience for whom that is the ideal.

[Link To Benchmarks](#alacritty-emulator-benchmarks)

### Rio

Rio is a modern terminal emulator built in Rust, and has a surprising amount of features for what appears to be mostly a one-man-band project.  Perhaps its most unique "hook" is its integration with RetroArch shaders, allowing a degree of customization over the look/feel of your terminal that can't really be had anywhere else.  These shaders can range from CRT emulation like Cool-Retro-Term all the way to the truly bizarre.  Productive?  Probably not, but they are genuinely cool.  Rio also sports a configurable "hints" system that can show/suggest keybinds where relevant, which is a neat feature.  Overall, Rio does a lot right: it's fast, feature rich, supports every image protocol, and has a much smaller binary footprint than similar competitors.  Unfortunately, I also think it just tends to be a little buggier in my testing than many of the other options (I just opened it to an immediate freeze while typing this), and it doesn't do quite enough good to launch it into the [Superlatives](the superlatives) category regardless.

### iTerm2

iTerm2 (iterm) is a very old, very feature complete terminal that stands as one of the jewels of the MacOS development ecosystem, widely beloved by users for well over a decade at this point.  It is the gold standard for color support, introduced its own image protocol, and had built in multiplexing long before any of the Linux options I have covered dared to try it.  It's not all roses, however: iterm is slow compared to many of the modern options (slow enough I thought something might be wrong while benchmarking it), favors an absolutely sprawling GUI config rather than file-based config (a matter of taste, but I find the latter strongly preferable), is very resource hungry at <350MB of idle RAM consumption, and has somewhat dated and less than excellent documentation.  I also find its scripting cumbersome compared to, say, WezTerm.  Still, it has *a lot* of devoted adherents, and in my research for this piece I believe I discovered why: iterm was "good" before anything else was.  All of those "modern" features I listed? iterm was doing them 10 years ago, long before anyone else.  I don't use iterm anymore for a number of reasons (I think other choices have mostly surpassed it, and I value having cross platform solutions), but it is easy to see why it has built such a strong following.  It has faithfully carried users from before I ever wrote "Hello World" into the modern day while scarcely showing its age, and that is something to be proud of.  

Best for: 
- Happy users who don't feel like a switch 
- Mac loyalists

[Link To Benchmarks](#iterm2-emulator-benchmarks)

## The Superlatives

The following terminals can be used by everyone, but in my opinion also represent the true endgame for terminal enthusiasts.  These terminals vary significantly in terms of their strengths, empahsis, and underlying technologies leveraged, but all share the following: Great user experience, high configurability, and cutting edge features.  I recommend all of the terminals here unreservedly, and have enjoyed my time with each of them.

### WezTerm

WezTerm is a a terminal emulator by developer Wez Furlong, written in Rust and featuring all the goodies one could imagine in a modern terminal emulator.  That isn't an exaggeration - If I had to pick the single most feature-rich terminal, I would pick WezTerm.  It might be easier to list the things it *doesn't* do.  It supports every image protocol under the sun.  It has a special "copy mode" to enable easy selection of text without reaching for the mouse.  It has its own special enhanced ssh integration with a built in custom library.  It possesses built in support for multiplexing without the use of tmux/screen/zellij/any other third party solution.  It is a pioneer of highly configurable scrollback with a multitude of unique settings.  It has very thorough and digestible [documentation](https://wezterm.org).  Rather than a GUI config or a toml/json/conf file, it is configured in the Lua scripting language, allowing condional config and scripting potential that is virtually unmatched in the terminal space.  With all of these positives, one might ask: Why would you ever use another terminal?  For starters, it isn't the fastest, or even close.  In terms of both startup time and benchmarking metrics, it is easily the slowest of the Superlatives.  It is also the least actively maintained of this group, not seeing a major release since Feb. 2024.  Furthermore, most of these fun, advanced features require a significant amount of configuration to take full advantage of, which brings us to the next point:  Lua config can be a double edged sword.  While the incredible amount of extensibility it offers is no doubt appealing to many, just as many others won't want to put a lot of time into actually "programming" their terminal config.  WezTerm's defaults are really nothing special, and unless you're already a Lua wiz (looking at you, Neovim users), it takes little bit of work to get where you want to be, certainly the most of any of the maximalist emulators.  Even still, all of the positives I previously mentioned still stand, and it's  fast enough that most people would never perceive the difference in speed without actively looking.  All in all, WezTerm comes *highly* recommended from me.

Best for:
- People who demand the utmost in customizability from their terminal
- Tinkerers: those who genuinely enjoy exploring the possiblities with tooling.

[Link To Benchmarks](#wezterm-emulator-benchmarks)

### kitty

kitty's tagline is "If you live in the terminal, then kitty is made for YOU!" A bold, albeit playful claim.  One that of course begs the question: Does Kitty live up to it? I would say yes, to the point where I will open this section by saying that kitty is my current terminal of choice, and I have been very happy with it.  Firstly the good:  kitty is extremely performant.  In fact it is in contention with Alacritty for *most* performant terminal, and is infinitely more feature rich than that one competitor.  In terms of what Kitty can do, its only real competition is WezTerm in terms of feature richness and flexibility.  Configuration in kitty is done in a massive kitty.conf file, which can be intimidating at first, but is probably the single most exhaustively commented file I have ever encountered.  It also does not require the user to learn Lua for configuration if they are not familiar (although I wouldn't call basic Lua terribly prohibitive), which is also a plus.  The existence of a config file might suggest that things are less scriptable than with WezTerm, but that is not necessarily the case.  Instead of a using the same setup for configuration and scripting like WezTerm does with Lua, Kitty has the concept of "kittens" (awww), which are small Python (and sometimes Go) programs that can be used to script terminal behavior.  These kittens can be very powerful, with some of the built in ones enabling a menu of hotswappable themes, a clipboard protocol that works even over ssh, a custom in-terminal diffing solution, and much more.  Overall, I would say that creating your own kittens has a somewhat higher barrier to entry than just extending your Lua config in WezTerm, but this is balanced by the fact that basic configuration with a .conf file requires a lesser initial investment.  In terms of multiplexing, kitty's solution is called "sessions", which are simple scripts in .kitty-sessions files that define a layout/programs to launch for kitty and are then called with a keybind or command.  With all of those positives, one might be tempted to ask "What are the downsides of kitty?" And truthfully, one of the biggest bits of praise is to acknowledge that that the shoe never really drops.  I have yet to really find any major downsides with the terminal itself.  Indeed, the only prevalent complaint I see other people have with kitty is a dislike of the primary maintainer (Kovid Goyal, who is also the main author of Calibre), who is known to be more than a little prickly at times.  As far the program itself though, kitty knocks it out of the park, and I can't think of a stronger recommendation than reiterating that it's what I now use every day.

Best for:
- Terminal users willing to do some configuration, but not necessarily as much as with WezTerm
- Those demanding the utmost performance while still maintaining the highest level of feature completeness

[Link To Benchmarks](#kitty-emulator-benchmarks)

[Link To macOS Benchmarks](#kitty-macos-emulator-benchmarks)

### Ghostty

Ghostty is by far the newest of the terminals in this section, being less than two years old (for its public release).  It is known for being what is probably the flagship application for the relatively new low level language Zig.  This is significant detail not just for language enthusiasts, but because of what it means for Ghostty as part of an ecosystem: being the public face of a whole language means Ghostty is likely to get a lot of extra attention, and with extra attention comes extra development and more maintainers.  Indeed, despite being less than a quarter of kitty's age, it already has a similar number of commits from an even greater number of contributors.  Ghostty is also known for using native rendering for each major platform.  WezTerm and kitty look like themselves regardless of whether the user is on Windows, Mac, or Linux.  By contrast, Ghostty looks like a native Mac app on my Macbook, and the sharpness and coherency of the design immediately jumps out.  As for performance, Ghostty does not *quite* meet the lofty standards set by Alacritty and Kitty, but in truth the margin of difference is small enough that it is vanishingly unlikely to be meaningful in the real world; it is not the difference between slow and fast, but rather lightspeed and ludicrous speed.  As for configuration and features, Ghostty does lag slightly behind its older compatriots.  Ghostty config is done in a very simple .ghostty file that uses an extremely simplified "key=value" syntax, and relies on online reference documentation to provide a list of the available options.  It also lacks any native support for advanced scripting features that Kitty and Wezterm have, as well as having no built in session/multiplexing abilities, relying on tmux or similar external software.  This might lead the reader to wonder: "If it's just fast and pretty, does it really stack up to the best?" The answer to that is "yes", for two reasons, the first of which was already touched on: It has the most active development of any terminal.  The momentum behind it is incredible, and if I had to pick a terminal cart to attach my metaphorical horse to for future purposes, I would choose Ghostty.  It does not have quite all of the niceties of Kitty/WezTerm *now*, but I can very easily imagine a future world in which it does.  The second reason is even more important, and one that we have yet to cover: The fact that, out of the box, Ghostty blows every other terminal away.  Other terminals take what I would call a very old school approach to configuration: they are incredibly power, but little to nothing is done for you.  The concept of a "sensible default" is treated as an affront to generations of tinkerers who enjoy spending an inordinate amount of time configuring and hacking to make the software truly their own.  Ghostty takes the opposite approach, aiming for "zero config for most users", and it shows.  Ghostty is imminently usable and beautiful immediately after installation, and many of the nicest things about it are discoverable without so much as reading a line of documentation.  I myself *am* one of those tinkering weirdos, but I also recognize that the majority of users are not, and I truly wish that other terminals would take a lesson from Ghostty and ship an experience that doesn't require digging to find any of the magic.  Until then, Ghostty runs absolute laps around the competition in this department.

Best for:
- People who just want to download a terminal and be done with it, without missing out.
- People playing the long game and choosing based on what might be best in the future
- Zig enthusiasts

[Link To Benchmarks](#ghostty-emulator-benchmarks)

### Closing Thoughts:

I enjoyed trying out so many different terminals and learning more about them.  I did not at all enjoy compiling the benchmarks, to the point that it threatened to sour me on the whole process.  Neverthless, it is done now, and I hope that it may provide a measure of value to at least a small number of readers.

## Benchmarks Section

Below are the benchmarks taken for each of the terminal emulators.  They are here at the bottom for ease of comparison, and also so that they do not overwhelm the rest of the text.

### Foot Emulator Benchmarks

Idle RAM usage: 25 MB (normal), 18 MB (server mode), 31 MB total (active server/client)

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ---------- | ------------------- |
| Only ASCII chars | 717.43ms | 278.8 |
| Unicode chars | 1.57s | 115.6 |
| CSI codes with few chars | 1.65s | 60.6 |
| Long escape codes | 2.2s | 356.1 |
| Images | 1.15s | 463.3 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| cursor_motion | 2425 | 1.22 MiB | 3.68ms | < 4ms | 0.48ms |
| dense_cells | 2115 | 1.29 MiB | 4.12ms | < 5ms | 0.35ms |
| light_cells | 1940 | 1 MiB | 4.61ms | < 5ms | 0.55ms |
| scrolling | 81 | 1 MiB | 123.32ms | < 131ms | 7.21ms |
| scrolling_bottom_region | 79 | 1 MiB | 127.2ms | < 139ms | 10.09ms |
| scrolling_bottom_small_region | 81 | 1 MiB | 123.73ms | < 135ms | 7.78ms |
| scrolling_fullscreen | 1658 | 1 MiB | 5.57ms | < 6ms | 0.7ms |
| scrolling_top_region | 84 | 1 MiB | 119.69ms | < 128ms | 7.63ms |
| scrolling_top_small_region | 74 | 1 MiB | 136.05ms | < 147ms | 8.11ms |
| unicode | 1121 | 1.06 MiB | 8.39ms | < 8ms | 5.46ms |

#### 3) Startup Time (hyperfine, normal mode)

| Mode | Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |
| -------- | ----------- | --------- | ---------- | ---------- | ------ | ---------- | ------------ |
| Normal | 29.7 ms | 1.6 ms | 26.7 ms | 34.4 ms | 100 | 37.2 ms | 7.6 ms |

#### 4) Startup Time (hyperfine, client mode with server running)

| Mode | Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |
| ----------------------- | ----------- | --------- | ---------- | ---------- | ------ | ---------- | ------------ |
| Client (server alive) | 16.7 ms | 0.9 ms | 14.4 ms | 20.1 ms | 158 | 0.5 ms | 0.5 ms |

### Ghostty Emulator Benchmarks

Idle RAM usage: 188 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ------- | ------------------- |
| Only ASCII chars | 1.83s | 109.1 |
| Unicode chars | 1.59s | 114.0 |
| CSI codes with few chars | 1.98s | 50.5 |
| Long escape codes | 7.16s | 109.5 |
| Images | 7.64s | 69.8 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| cursor_motion | 1050 | 1.22 MiB | 9.19ms | < 10ms | 0.53ms |
| dense_cells | 768 | 1.29 MiB | 12.34ms | < 13ms | 0.7ms |
| light_cells | 1260 | 1 MiB | 7.27ms | < 8ms | 0.56ms |
| scrolling | 63 | 1 MiB | 158.63ms | < 180ms | 16.51ms |
| scrolling_bottom_region | 62 | 1 MiB | 161.39ms | < 181ms | 14.11ms |
| scrolling_bottom_small_region | 63 | 1 MiB | 158.86ms | < 178ms | 16.72ms |
| scrolling_fullscreen | 670 | 1 MiB | 14.45ms | < 16ms | 1.54ms |
| scrolling_top_region | 64 | 1 MiB | 157.88ms | < 182ms | 16.57ms |
| scrolling_top_small_region | 62 | 1 MiB | 160.97ms | < 180ms | 14.09ms |
| unicode | 992 | 1.06 MiB | 9.59ms | < 11ms | 1.79ms |

#### 3) Startup Time (hyperfine, normal mode)

| Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |
| ----------- | --------- | ---------- | ---------- | ------ | ---------- | ------------ |
| 258.5 ms | 18.9 ms | 245.0 ms | 297.8 ms | 10 | 173.2 ms | 111.9 ms |

### Cool Retro Term Emulator Benchmarks

Idle RAM usage: 218 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | -------- | ------------------- |
| Only ASCII chars | 6.23s | 32.1 |
| Unicode chars | 3s | 60.3 |
| CSI codes with few chars | 2.02s | 49.6 |
| Long escape codes | 5.06s | 154.8 |
| Images | 13.87s | 38.5 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| cursor_motion | 805 | 1.22 MiB | 11.74ms | < 12ms | 2.29ms |
| dense_cells | 780 | 1.29 MiB | 12.21ms | < 12ms | 4.54ms |
| light_cells | 590 | 1 MiB | 16.4ms | < 17ms | 1.81ms |
| scrolling | 45 | 1 MiB | 225.04ms | < 235ms | 5.94ms |
| scrolling_bottom_region | 54 | 1 MiB | 187.74ms | < 200ms | 10.6ms |
| scrolling_bottom_small_region | 58 | 1 MiB | 174.21ms | < 214ms | 25.12ms |
| scrolling_fullscreen | 327 | 1 MiB | 30.35ms | < 30ms | 2.05ms |
| scrolling_top_region | 54 | 1 MiB | 185.91ms | < 208ms | 13.73ms |
| scrolling_top_small_region | 61 | 1 MiB | 165.92ms | < 187ms | 15.34ms |
| unicode | 706 | 1.06 MiB | 13.84ms | < 13ms | 14.89ms |

#### 3) Startup Time (hyperfine, normal mode)

| Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |
| ----------- | --------- | ---------- | ---------- | ------ | ---------- | ------------ |
| 375.0 ms | 27.2 ms | 345.2 ms | 444.8 ms | 10 | 156.1 ms | 185.6 ms |

### Contour Emulator Benchmarks

Passive RAM usage: 288 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ------- | ------------------- |
| Only ASCII chars | 6.04s | 33.1 |
| Unicode chars | 6.31s | 28.7 |
| CSI codes with few chars | 2.97s | 33.7 |
| Long escape codes | 3.44s | 227.6 |
| Images | 1.58s | 336.9 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| cursor_motion | 843 | 1.22 MiB | 11.09ms | < 11ms | 0.36ms |
| dense_cells | 1320 | 1.29 MiB | 7.04ms | < 7ms | 0.22ms |
| light_cells | 371 | 1 MiB | 26.38ms | < 27ms | 0.52ms |
| scrolling | 68 | 1 MiB | 146.82ms | < 165ms | 16.58ms |
| scrolling_bottom_region | 56 | 1 MiB | 180.79ms | < 196ms | 11.85ms |
| scrolling_bottom_small_region | 57 | 1 MiB | 175.44ms | < 191ms | 10.39ms |
| scrolling_fullscreen | 539 | 1 MiB | 18.01ms | < 18ms | 0.14ms |
| scrolling_top_region | 55 | 1 MiB | 182.53ms | < 193ms | 8.24ms |
| scrolling_top_small_region | 56 | 1 MiB | 178.95ms | < 190ms | 9.13ms |
| unicode | 299 | 1.06 MiB | 32.93ms | < 34ms | 1ms |

#### 3) Startup Time (hyperfine, normal mode)

| Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |
| ----------- | --------- | ---------- | ---------- | ------ | ---------- | ------------ |
| 375.0 ms | 27.2 ms | 345.2 ms | 444.8 ms | 10 | 156.1 ms | 185.6 ms |

### Alacritty Emulator Benchmarks

Idle RAM usage: 143 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ------- | ------------------- |
| Only ASCII chars | 1.68s | 118.9 |
| Unicode chars | 1.32s | 137.5 |
| CSI codes with few chars | 1.33s | 75.3 |
| Long escape codes | 5.71s | 137.4 |
| Images | 1.31s | 406.3 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| cursor_motion | 1624 | 1.22 MiB | 5.77ms | < 6ms | 0.52ms |
| dense_cells | 1603 | 1.29 MiB | 5.95ms | < 6ms | 0.3ms |
| light_cells | 2042 | 1 MiB | 4.17ms | < 5ms | 0.42ms |
| scrolling | 86 | 1 MiB | 116.47ms | < 125ms | 5.67ms |
| scrolling_bottom_region | 84 | 1 MiB | 119.21ms | < 129ms | 7.93ms |
| scrolling_bottom_small_region | 83 | 1 MiB | 120.18ms | < 132ms | 9.2ms |
| scrolling_fullscreen | 925 | 1 MiB | 10.32ms | < 12ms | 1.73ms |
| scrolling_top_region | 83 | 1 MiB | 120.24ms | < 129ms | 7.32ms |
| scrolling_top_small_region | 82 | 1 MiB | 121.79ms | < 129ms | 5.64ms |
| unicode | 1803 | 1.06 MiB | 5.02ms | < 5ms | 0.15ms |

#### 3) Startup Time (hyperfine, normal mode)

| Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |
| ----------- | --------- | ---------- | ---------- | ------ | ---------- | ------------ |
| 156.4 ms | 25.7 ms | 137.6 ms | 229.5 ms | 12 | 67.5 ms | 84.8 ms |

### Ptyxis Emulator Benchmarks

Idle RAM usage: 242 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ------- | ------------------- |
| Only ASCII chars | 1.13s | 177.3 |
| Unicode chars | 1.59s | 113.8 |
| CSI codes with few chars | 2.41s | 41.5 |
| Long escape codes | 3.3s | 237.5 |
| Images | 2.17s | 246.1 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| cursor_motion | 796 | 1.22 MiB | 12.05ms | < 32ms | 13.23ms |
| dense_cells | 784 | 1.29 MiB | 12.36ms | < 27ms | 11.35ms |
| light_cells | 3412 | 1 MiB | 2.48ms | < 5ms | 2.32ms |
| scrolling | 62 | 1 MiB | 160.92ms | < 170ms | 6.76ms |
| scrolling_bottom_region | 64 | 1 MiB | 157.69ms | < 167ms | 7.22ms |
| scrolling_bottom_small_region | 61 | 1 MiB | 165.2ms | < 173ms | 6.96ms |
| scrolling_fullscreen | 796 | 1 MiB | 12.08ms | < 15ms | 3.26ms |
| scrolling_top_region | 59 | 1 MiB | 171.39ms | < 184ms | 9.07ms |
| scrolling_top_small_region | 60 | 1 MiB | 168.82ms | < 178ms | 7.36ms |
| unicode | 757 | 1.06 MiB | 12.71ms | < 32ms | 23.32ms |

#### 3) Startup Time (hyperfine, normal mode)

| Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |
| ----------- | --------- | ---------- | ---------- | ------ | ---------- | ------------ |
| 488.1 ms | 24.2 ms | 443.9 ms | 531.0 ms | 10 | 234.5 ms | 224.5 ms |

### Konsole Emulator Benchmarks

Idle RAM usage: 129 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | -------- | ------------------- |
| Only ASCII chars | 3.92s | 51.1 |
| Unicode chars | 2.44s | 74.0 |
| CSI codes with few chars | 2.57s | 39.0 |
| Long escape codes | 10.1s | 77.6 |
| Images | 17.58s | 30.3 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| cursor_motion | 701 | 1.22 MiB | 13.93ms | < 17ms | 1.89ms |
| dense_cells | 676 | 1.29 MiB | 14.11ms | < 18ms | 2.53ms |
| light_cells | 701 | 1 MiB | 13.83ms | < 16ms | 1.75ms |
| scrolling | 56 | 1 MiB | 180.55ms | < 202ms | 17.09ms |
| scrolling_bottom_region | 60 | 1 MiB | 169.3ms | < 190ms | 21.21ms |
| scrolling_bottom_small_region | 59 | 1 MiB | 171.75ms | < 194ms | 18.09ms |
| scrolling_fullscreen | 460 | 1 MiB | 21.35ms | < 31ms | 4.74ms |
| scrolling_top_region | 66 | 1 MiB | 152.24ms | < 183ms | 20.44ms |
| scrolling_top_small_region | 63 | 1 MiB | 159.17ms | < 191ms | 22.53ms |
| unicode | 681 | 1.06 MiB | 14.07ms | < 11ms | 56.25ms |

#### 3) Startup Time (hyperfine, normal mode)

| Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |
| ----------- | --------- | ---------- | ---------- | ------ | ---------- | ------------ |
| 189.1 ms | 6.8 ms | 172.8 ms | 199.8 ms | 15 | 116.3 ms | 35.2 ms |

### Warp Emulator Benchmarks

Warp refused to provide output and resisted my attempts to attain benchmarks with the both vtebench and hyperfine.  I would imagine that has to do with some bit of being standards non-compliant, but I will admit that I did not dig terribly deep.  Anecdotally, it's noticeably slower than the best options, but not to the point of being a major problem.

Idle RAM usage: 582 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ------- | ------------------- |
| Only ASCII chars | 3.76s | 53.2 |
| Unicode chars | 3.03s | 59.7 |
| CSI codes with few chars | 3.03s | 33.0 |
| Long escape codes | 4.16s | 188.5 |
| Images | 3.44s | 155.1 |

### Terminal.app Emulator Benchmarks

Idle RAM usage: 44 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ------- | ------------------- |
| Only ASCII chars | 4.19s | 47.8 |
| Unicode chars | 2.93s | 61.8 |
| CSI codes with few chars | 2.14s | 46.8 |
| Long escape codes | 4.99s | 157.3 |
| Images | 5.61s | 95.1 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| dense_cells | 485 | 1 MiB | 20.01ms | < 20ms | 0.17ms |
| medium_cells | 283 | 1.02 MiB | 34.93ms | < 36ms | 0.94ms |
| scrolling | 60 | 1 MiB | 140.98ms | < 143ms | 31.43ms |
| scrolling_bottom_region | 87 | 1 MiB | 115.09ms | < 117ms | 1.28ms |
| scrolling_bottom_small_region | 87 | 1 MiB | 115.4ms | < 117ms | 1.1ms |
| scrolling_fullscreen | 55 | 1 MiB | 156.45ms | < 159ms | 22.04ms |
| scrolling_top_region | 87 | 1 MiB | 115.22ms | < 116ms | 1.23ms |
| scrolling_top_small_region | 86 | 1 MiB | 115.94ms | < 117ms | 0.79ms |
| sync_medium_cells | 271 | 1.06 MiB | 36.46ms | < 40ms | 7.47ms |
| unicode | 597 | 1.06 MiB | 16.26ms | < 48ms | 20.92ms |

### iTerm2 Emulator Benchmarks

Idle RAM usage: 377 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ------- | ------------------- |
| Only ASCII chars | 9.09s | 22.0 |
| Unicode chars | 15.93s | 11.4 |
| CSI codes with few chars | 37.28s | 2.7 |
| Long escape codes | 10.04s | 78.1 |
| Images | 19.34s | 27.6 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| dense_cells | 103 | 1 MiB | 96.66ms | < 123ms | 19.18ms |
| medium_cells | 19 | 1.02 MiB | 539.68ms | < 576ms | 26.35ms |
| scrolling | 180 | 1 MiB | 29.11ms | < 33ms | 2.87ms |
| scrolling_bottom_region | 18 | 1 MiB | 560.11ms | < 569ms | 4.54ms |
| scrolling_bottom_small_region | 18 | 1 MiB | 559.61ms | < 565ms | 4.82ms |
| scrolling_fullscreen | 134 | 1 MiB | 47.05ms | < 55ms | 4.93ms |
| scrolling_top_region | 4 | 1 MiB | 2711.5ms | < 2768ms | 42.65ms |
| scrolling_top_small_region | 18 | 1 MiB | 562.94ms | < 583ms | 10.03ms |
| sync_medium_cells | 17 | 1.06 MiB | 611.24ms | < 623ms | 9.86ms |
| unicode | 104 | 1.06 MiB | 97.61ms | < 82ms | 141.24ms |

### xfce4-term Emulator Benchmarks

Idle RAM usage: 51 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ---------- | ------------------- |
| Only ASCII chars | 937.42ms | 213.4 |
| Unicode chars | 1.46s | 124.1 |
| CSI codes with few chars | 2.7s | 37.0 |
| Long escape codes | 3.11s | 252.2 |
| Images | 2.06s | 258.9 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| cursor_motion | 885 | 1.22 MiB | 10.64ms | < 57ms | 26.94ms |
| dense_cells | 932 | 1.29 MiB | 10.48ms | < 42ms | 18.32ms |
| light_cells | 2382 | 1 MiB | 3.83ms | < 15ms | 6.06ms |
| scrolling | 61 | 1 MiB | 165.13ms | < 166ms | 20.84ms |
| scrolling_bottom_region | 68 | 1 MiB | 147.85ms | < 156ms | 6.55ms |
| scrolling_bottom_small_region | 65 | 1 MiB | 153.52ms | < 172ms | 14.94ms |
| scrolling_fullscreen | 965 | 1 MiB | 9.87ms | < 14ms | 3.91ms |
| scrolling_top_region | 71 | 1 MiB | 141.3ms | < 148ms | 5.32ms |
| scrolling_top_small_region | 71 | 1 MiB | 141ms | < 152ms | 8.31ms |
| unicode | 708 | 1.06 MiB | 13.91ms | < 30ms | 45.49ms |

### st Emulator Benchmarks

Idle RAM usage: 14 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | -------- | ------------------- |
| Only ASCII chars | 2.93s | 68.3 |
| Unicode chars | 1.95s | 92.9 |
| CSI codes with few chars | 12.85s | 7.8 |
| Long escape codes | 7.59s | 103.3 |
| Images | 5.09s | 104.7 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| cursor_motion | 697 | 1.22 MiB | 14ms | < 14ms | 2.35ms |
| dense_cells | 225 | 1.29 MiB | 44.01ms | < 46ms | 3.67ms |
| light_cells | 820 | 1 MiB | 11.79ms | < 12ms | 0.68ms |
| scrolling | 44 | 1 MiB | 228.18ms | < 230ms | 1.63ms |
| scrolling_bottom_region | 52 | 1 MiB | 192.31ms | < 194ms | 1.67ms |
| scrolling_bottom_small_region | 55 | 1 MiB | 184.27ms | < 186ms | 3.75ms |
| scrolling_fullscreen | 580 | 1 MiB | 16.84ms | < 17ms | 0.7ms |
| scrolling_top_region | 53 | 1 MiB | 191.53ms | < 192ms | 0.82ms |
| scrolling_top_small_region | 54 | 1 MiB | 186.7ms | < 190ms | 4.28ms |
| unicode | 26 | 1.06 MiB | 412.46ms | < 1164ms | 478.29ms |

#### 3) Startup Time (hyperfine, normal mode)

| Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |
| ----------- | --------- | ---------- | ---------- | ------ | ---------- | ------------ |
| 65.7 ms | 14.9 ms | 36.6 ms | 99.8 ms | 46 | 11.8 ms | 4.4 ms |

### WezTerm Emulator Benchmarks

Idle RAM usage: 138 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ------- | ------------------- |
| Only ASCII chars | 7.28s | 27.5 |
| Unicode chars | 3.74s | 48.4 |
| CSI codes with few chars | 5.19s | 19.3 |
| Long escape codes | 4.06s | 193.1 |
| Images | 1.51s | 352.2 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| cursor_motion | 557 | 1.22 MiB | 17.5ms | < 28ms | 5.27ms |
| dense_cells | 589 | 1.29 MiB | 16.51ms | < 25ms | 4.77ms |
| light_cells | 272 | 1 MiB | 36.29ms | < 44ms | 11.37ms |
| scrolling | 63 | 1 MiB | 160.02ms | < 172ms | 9.72ms |
| scrolling_bottom_region | 60 | 1 MiB | 166.9ms | < 180ms | 10.44ms |
| scrolling_bottom_small_region | 58 | 1 MiB | 173.28ms | < 184ms | 8.06ms |
| scrolling_fullscreen | 291 | 1 MiB | 33.98ms | < 41ms | 4.79ms |
| scrolling_top_region | 59 | 1 MiB | 170.76ms | < 183ms | 9.39ms |
| scrolling_top_small_region | 60 | 1 MiB | 168.98ms | < 183ms | 12.57ms |
| unicode | 328 | 1.06 MiB | 29.99ms | < 47ms | 15.58ms |

#### 3) Startup Time (hyperfine, normal mode)

| Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |
| ----------- | --------- | ---------- | ---------- | ------ | ---------- | ------------ |
| 180.9 ms | 8.9 ms | 170.7 ms | 197.8 ms | 15 | 96.0 ms | 73.2 ms |

### Kitty Emulator Benchmarks

Idle RAM usage: 131 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ------- | ------------------- |
| Only ASCII chars | 1.64s | 122.2 |
| Unicode chars | 1.35s | 134.0 |
| CSI codes with few chars | 2.34s | 42.7 |
| Long escape codes | 2.37s | 331.2 |
| Images | 1.85s | 288.8 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| cursor_motion | 292 | 1.22 MiB | 33.82ms | < 66ms | 17.26ms |
| dense_cells | 542 | 1.29 MiB | 18.03ms | < 29ms | 6.86ms |
| light_cells | 1519 | 1 MiB | 6.11ms | < 6ms | 0.51ms |
| scrolling | 67 | 1 MiB | 149.28ms | < 161ms | 7.81ms |
| scrolling_bottom_region | 70 | 1 MiB | 142.53ms | < 153ms | 8.59ms |
| scrolling_bottom_small_region | 70 | 1 MiB | 144.16ms | < 154ms | 7.82ms |
| scrolling_fullscreen | 995 | 1 MiB | 9.53ms | < 11ms | 1.05ms |
| scrolling_top_region | 70 | 1 MiB | 143.76ms | < 152ms | 6.58ms |
| scrolling_top_small_region | 69 | 1 MiB | 144.91ms | < 156ms | 10.08ms |
| unicode | 81 | 1.06 MiB | 127.01ms | < 10ms | 629.32ms |

#### 3) Startup Time (hyperfine, normal mode)

| Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |
| ----------- | --------- | ---------- | ---------- | ------ | ---------- | ------------ |
| 221.1 ms | 14.7 ms | 210.2 ms | 261.6 ms | 11 | 127.4 ms | 87.2 ms |

### Kitty macOS Emulator Benchmarks

Idle RAM usage: 95 MB

#### 1) Kitty Benchmark Results

| Test | Time | Throughput (MB/s) |
| --------------------------- | ------- | ------------------- |
| Only ASCII chars | 1.56s | 128.2 |
| Unicode chars | 1.14s | 158.6 |
| CSI codes with few chars | 1.28s | 78.0 |
| Long escape codes | 2.37s | 330.5 |
| Images | 1.81s | 295.0 |

#### 2) vtebench Results

| Test | Samples | Payload | Avg Time | P90 Time | Std Dev |
| ------------------------------- | --------- | ---------- | ---------- | ---------- | --------- |
| dense_cells | 737 | 1 MiB | 13.04ms | < 13ms | 0.36ms |
| medium_cells | 724 | 1.02 MiB | 13.36ms | < 17ms | 2.5ms |
| scrolling | 132 | 1 MiB | 62.88ms | < 81ms | 17.11ms |
| scrolling_bottom_region | 359 | 1 MiB | 27.34ms | < 33ms | 5.02ms |
| scrolling_bottom_small_region | 357 | 1 MiB | 27.51ms | < 33ms | 4.98ms |
| scrolling_fullscreen | 76 | 1 MiB | 116.55ms | < 119ms | 1.66ms |
| scrolling_top_region | 366 | 1 MiB | 26.84ms | < 32ms | 4.8ms |
| scrolling_top_small_region | 356 | 1 MiB | 27.59ms | < 33ms | 5.05ms |
| sync_medium_cells | 611 | 1.06 MiB | 15.86ms | < 16ms | 1.85ms |
| unicode | 845 | 1.06 MiB | 11.42ms | < 8ms | 19.25ms |
