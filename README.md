# haskellPoker 🃏

## Introduction
Texas Holdem Poker written in Haskell

### Rankings
1. **Royal flush** is an ace high straight flush. For example, ```[1D, 13D, 12D, 11D, 10D]```
2. **Straight flush** is a five-card straight, all in the same suit. For example, ```[7S, 6S, 5S, 4S, 3S]```
3. **Four of a kind** are four cards of equal value. For example, ```[11S, 11D, 11C, 11H]```
4. **Full house** contains a set (3) of cards of one value and a pair of another value. For example, ```[12D, 12S, 12H, 2S, 2D]```
5. **Flush** is any 5 cards, all of the same suit. For example, ```[13D, 12D, 9D, 6D, 3D]```
6. **Straight** is five cards of sequential value. For example, ```[7H, 6D, 5S, 4C, 3H]```
7. **Three of a kind** is three cards of the same value. For example, ```[1H, 1D, 1C]```
8. **Two pairs** is two cards of one value and another two cards of another value. For example, ```[11D, 11H, 8S, 8C]```
9. **Pair** is two cards of the same rank. For example, ```[12D, 12H]```
10. **High card** is the hand with the highest card(s) wins. If both players hold the highest card, a kicker comes into play,

### Tie Breaking

## How to Run
In the project directory, run ``` :load Poker.hs ```. Then, run the ```deal``` function with your desired deck.

**Note:** the deck must consist of 9 valid card inputs. 

Example:
```
> :load Poker.hs
> deal [51,8,11,6,4,31,3,13,9]
> ["11C","13C","3C","4C","9C"]
```

## Acknowledgments
This project was assigned by Professor Ufkes and created for CPS506 - Comparative Programming Languages W2021

haskellPoker is built by:
* [Alyanna Santos](https://github.com/al-yanna)
* [Ralph Liton](https://github.com/rlitoncs)
