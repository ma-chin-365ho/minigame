

class MancalaRule():

    def __init__(self, cnt_player, cnt_pocket, cnt_start_stone):
        self.cnt_player = cnt_player
        self.cnt_pocket = cnt_pocket
        self.cnt_start_stone = cnt_start_stone
        self.pocket = [[cnt_start_stone for x in range(cnt_pocket)] for y in range(cnt_player)]
        self.goal = [0] * cnt_player
        self.selectable_n_players = [c for c in range(self.cnt_player)]
        self.selectable_n_pockets = [c for c in range(self.cnt_pocket)]
        self.turn_n_player = None
        self.winner = None
        return

    def take_stone(self, n_pocket):
        n_player = self.turn_n_player
        cnt_stone = self.pocket[n_player][n_pocket]
        self.pocket[n_player][n_pocket] = 0
        pos_player = n_player
        pos_pocket = n_pocket
        for c in range(cnt_stone):
            pos_pocket += 1
            if pos_pocket == self.cnt_pocket:
                self.goal[pos_player] +=1
                if c == cnt_stone - 1:
                    # ゴールでちょうど終わる時
                    self.winner = self.__get_winner()
                    if self.winner is None:
                        self.turn_n_player = n_player
                    else:
                        self.turn_n_player = None
                    return
                else:
                    pos_pocket = -1 # ポジションが最初に戻る。
                    pos_player = self.__next_player(pos_player)
            else:          
                self.pocket[pos_player][pos_pocket] += 1
        self.winner = self.__get_winner()
        if self.winner is None:
            self.turn_n_player = self.__next_player(n_player)
        else:
            self.turn_n_player = None
        return

    def is_selectable_pocket(self, n_player, n_pocket):
        if not n_pocket in self.selectable_n_pockets:
            return False
        if self.pocket[n_player][n_pocket] == 0:
            return False
        return True

    def __next_player(self, now_n_player):
        next_n_player = now_n_player + 1
        if next_n_player == self.cnt_player:
            next_n_player = 0
        return next_n_player

    def __get_winner(self):
        """
        Returns: None: 未確定
                数値: 勝者のプレイヤー番号
        """
        for n_player, pocket_player in enumerate(self.pocket):
            if all([c == 0 for c in pocket_player]):
                return n_player
        return None