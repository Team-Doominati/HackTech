The Player
==========

Level
-----
* Most interactions inside of systems will give you XP
* Each level will give you one stat point
* There is no level or stat cap

Reputation
----------

* Completing missions will increase your reputation, while abandoning/failing them via either missing the deadline or failing a mission-specific condition will reduce your reputation
* When your reputation levels up, more difficult missions will become available to you
* You must choose to manually approve a reputation upgrade, as doing so will increase your living expenses as well
* Higher reputation will give you access to better hardware and software
* Higher reputation will let you special order higher level hardware and software if you don't have the skills to make it yourself
* Higher reputation will give you more payout when selling off valuable data files

Monthly Payments
----------------

* Your monthly payments must be paid every 30 days
* Your payment is broken down into several categories
    * **Living Expenses** - Expenses for everyday living
    * **Software Licenses** - Keeping your development software up-to-date, directly related to your **Programming** stat
    * **Hardware Maintenance** - Keeping your deck and development hardware up-to-date and maintained, directly related to your **Engineering** stat
    * **Medical Care** - If you stayed at a hospital to restore mental/physical health, the bill will be taken out of your monthly payments
    * **Fines** - If you are dumped from a system, you will be fined by the authorities, this fine is added to your monthly payment
* If you don't have enough money to handle your monthly payment, your account will go negative
* if you owe too much money due to a negative balance, the game is over

Mental & Physical Health
------------------------

* Both mental and physical health are decreased by certain ICE attacks and actions
* They are both restored slightly after each day
* You can visit the hospital for a day to regain your full mental and physical health for a cost
* If either one reaches 0%, you die, and the game is over

Stats
-----

To upgrade a stat, you must have unspent stat points equal to the next level of the stat you're going to upgrade to

* **Attack** - Increases your attack damage and accuracy and also affects attack programs
* **Defense** - Increases your base mental/physical defense and also affects defense programs
* **Stealth** - Lowers chances of spot checks and also affects stealth programs
* **Analysis** - Lowers the chance of protection ICE noticing analysis and also affects analysis programs
* **Programming** - Allows you to create higher-level programs and decreases the time needed to make them
* **Engineering** - Allows you to create higher-level hardware and firmware and decreases the time needed to make them
* **Negotiation** - Allows you to get better bonus payout on missions

The Deck
========

Hardware
--------

Each hardware type has an associated number of slots on the deck, which can either be upgraded via modifying the deck yourself or taking it to a shop and paying to have it done for you

* **CPU** - Determine the deck's processing power, important for handling intensive tasks done by analysis programs
* **SPU** - Determine the total size of the deck's thread pool, each passively running program will require a certain amount of threads in order to function
* **RAM** - Programs need to be loaded into RAM before they can be used
* **Storage** - Stores your programs and data files
* **Network** - Determine your download and upload speed when interacting with data stores and files
* **Expansion** - Special hardware such as monitors, proxies, etc

Software
--------

* Software must be loaded into the deck's RAM first before it can be used
* Many types of software, such as attacks, shields or crackers, can only have one "primary" copy loaded at a time

### Attack

Many attack program types can also have an area variant, which affects every ICE on the node

* **Attack** - A basic attack program, will damage shield first, then integrity
* **Break** - Targets an ICE's shield, dealing direct damage to it, deals more damage to shields and none to integrity
* **Pierce** - Pierces through an ICE's shield to damage integrity directly, but does less damage
* **Slice** - Cuts off a percentage of the ICE's shield or integrity
* **Scramble** - Does damage-over-time to an ICE's shield
* **Virus** - Does damage-over-time to an ICE's integrity
* **Slow** - Slows down an ICE's response rate
* **Confuse** - Prevents an ICE from performing actions for X amount of turns
* **Weaken** - Lower's an ICE's level, low success chance
* **Overclock** - Temporarily increases your damage

### Defense

* **Shield** - A shield which protects your deck integrity
* **Armor** - Provides a flat damage reduction to attacks hitting your integrity
* **Plating** - Provides a percentage damage reduction to attacks hitting your integrity
* **Medic** - Repairs deck integrity
* **Maintain** - Repairs shield
* **Regen** - Passively regenerates deck integrity
* **Nanogen** - Passively regenerates shield
* **Reflect** - A portion of damage received is reflected back at the attacking ICE

### Stealth

* **Deceive** - Attempts to trick the ICE into thinking you are a normal user
* **Relocate** - Used to delay an ICE's trace attempt
* **Camo** - Passive increase to avoiding ICE spot checks
* **Sleaze** - Passive chance to bypass ICE entirely when using a node
* **Silence** - Prevents ICE from activating an alert within the node
* **Smoke** - Decreases ICE attack accuracy within the node

### Analysis

* **Analyze** - Analyzes an ICE's properties
* **Scan** - Scans a node
* **Evaluate** - Scans a data store node's files for their value
* **Decrypt** - Decrypts encryption ICE from datastore nodes
* **Crack** - Cracks password ICE on nodes
* **Calculate** - Cracks hash algorithm ICE on nodes
* **Bypass** - Disables firewall ICE on nodes
* **Relay** - Bypasses proxy ICE on nodes
* **Synthesize** - Cracks audio/voice lock ICE on nodes

### Boost

Boosts come in either active or passive program form which increase a specific stat

* **Attack Boost**
* **Defense Boost**
* **Stealth Boost**
* **Analysis Boost**

Expansion Hardware
------------------

* Unique pieces of hardware with special properties
* Each upgrade is substantial, not a minor bonus
* Each piece of hardware will have a level cap, due to the substantial nature of the upgrades

Systems
=======

* Systems are made up of nodes connected together in a grid
* All actions in a system are turn based
* Each action will require at least one turn, while some actions, such as using analysis programs, may take several turns
* You can do nothing for a turn to let programs finish their work
* At the beginning of every turn, analysis ICE in your current node may spot check you (unless the system is on passive/active alert)
    * If the ICE is deceived, they will not spot check you (you cannot deceive non-analysis ICE types)
    * Stealth stat and stealth programs help prevent ICE from constantly spot checking you

Nodes
-----

A node is a point in the system which can be interacted with in some manner

### Security

Nodes are color-coded based on their security, more secure nodes will have more ICE in them

* **White** - No security
* **Green** - Low security
* **Yellow** - Medium Security
* **Orange** - High security
* **Red** - Maximum security

### Types

* **Access Point (AP)** - The node you will enter the system in
* **Junction (J)** - Connects other nodes and junctions together
* **Data Store (DS)** - Contains data files
* **Input/Output Port (IOP)** - Perform specific context-sensitive actions
* **Security Module (SM)** - Modify security-related features, such as the alert status
* **Central Processing Unit (CPU)** - Perform system-wide functions, such as obtaining a map or crashing the system

ICE
---

ICE are the programs which defend against intruders by protecting nodes

### Analysis

These ICE will spot check you and raise an alert if you are detected

### Attack

These ICE will attack you if an alert is triggered

### Protection

These ICE protect nodes from being accessed

* **Encryption** - Protects files in a data store node via encrypting them
* **Password** - Protects nodes with a password
* **Algorithm** - Protects nodes with a hash algorithm
* **Firewall** - Protects nodes with a firewall
* **Proxy** - Protects nodes with a proxy
* **Audio** - Protects nodes with an audio lock

Alert
-----

* There are three alert levels:
    * **Passive** alerts will mean that every analysis ICE will now try and spot check you when trying to access a node
    * **Active** alerts cause all analysis ICE to not bother doing spot checks and attack ICE will target and attack you immediately
    * **Shutdown** is the same as an active alert except that the system will be shut down in X amount of time, so do whatever you need to do fast
* You can lower the alert level by finding the SM node

Programming & Engineering
=========================

* **Programming** and **Engineering** allows you to create new hardware and software based on your stats, higher stats mean higher level hardware and software and less time required to make them
* **Attack**, **Defense**, **Stealth** and **Analysis** stats will directly gate the max level of those types of programs you can create as they are meant to be a representation of your "understanding" of how those programs function and operate, while Programming will be the *maximum* level of any given software you can create

