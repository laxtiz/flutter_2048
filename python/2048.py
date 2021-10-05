from typing import Iterable, List
from enum import Enum
from random import randint
import argparse


class MoveStep(str, Enum):
    UP = "u"
    DOWN = "d"
    LEFT = "l"
    RIGHT = "r"


class GameOverException(Exception):
    def __init__(self, msg: str):
        self.msg = msg


class Game:
    size: int
    data: List[List[int]]

    def __init__(self, *, size: int = 4) -> None:
        self.size = size

    def start(self, *, nums: int = 1):
        self.data = [[0 for _ in range(self.size)] for _ in range(self.size)]
        print(f"初始化棋盘 {self.size}x{self.size}")

        self.check()
        while True:
            self.show()
            while True:
                s = input("输入移动方向, 可选[u/d/l/r]: ")
                step = s.lower()[0]
                if step in "udlr":
                    break
            step = MoveStep(step)
            self.move(step)
            self.check()
            self.clear()

    def show(self):
        """打印棋盘"""
        for l in self.data:
            print(*l, sep="\t")

    def clear(self):
        print("\033c")

    def check(self):
        """检查游戏状态"""
        zeros = []
        for y in range(self.size):
            for x in range(self.size):
                if self.data[y][x] == 0:
                    zeros.append((x, y))

        if len(zeros) == 0:
            raise GameOverException("没有空地可生成新的数字")

        i = randint(0, len(zeros) - 1)
        x, y = zeros[i]
        self.data[y][x] = 1

    def move(self, move: MoveStep):
        """移动"""
        if move == MoveStep.UP:
            self._up()
        elif move == MoveStep.DOWN:
            self._down()
        elif move == MoveStep.LEFT:
            self._left()
        else:
            self._right()

    def _up(self):
        """整体向上移动"""
        self.data = [
            self._expand(it)
            for it in zip(*(self._expand(tidy(t)) for t in zip(*self.data)))
        ]

    def _down(self):
        """整体向下移动"""
        self.data = [
            self._expand(it)
            for it in zip(*(self._expand(tidy(t[::-1]))[::-1] for t in zip(*self.data)))
        ]

    def _left(self):
        """整体向左移动"""
        self.data = [self._expand(tidy(l)) for l in self.data]

    def _right(self):
        """整体向右移动"""
        self.data = [self._expand(tidy(l[::-1]))[::-1] for l in self.data]

    def _expand(self, it: Iterable[int]) -> List[int]:
        return (list(it) + [0] * self.size)[: self.size]


def tidy(it: Iterable[int]) -> Iterable[int]:
    l = list(it)
    while True:
        t = []
        for v in l:
            if v == 0:
                continue
            if len(t) > 0 and t[-1] == v:
                t[-1] += v
                continue
            t.append(v)
        if len(t) == len(l):
            break
        l = t
    return l


def main():
    parse = argparse.ArgumentParser()
    parse.add_argument("--size", "-s", type=int, default=4, metavar="4")
    options = parse.parse_args()

    game = Game(size=options.size)
    try:
        game.start()
    except GameOverException as e:
        print(e.msg)
        print("游戏结束, bye~")
    except KeyboardInterrupt:
        print("正在退出...")


if __name__ == "__main__":
    main()
