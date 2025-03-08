CNT_PLAYER = 2
CNT_POCKET = 3
CNT_START_STONE = 2
SELECTABLE_N_PLAYERS = [c for c in range(CNT_PLAYER)]
SELECTABLE_N_POCKETS = [c for c in range(CNT_POCKET)]
GAME_STOPPED_CODE = -1

pocket = [[CNT_START_STONE for x in range(CNT_POCKET)] for y in range(CNT_PLAYER)]
goal = [0] * CNT_PLAYER

def take_stone(n_player, n_pocket):
    """
    Returns: True:ターンチェンジする、False:しない
    """
    cnt_stone = pocket[n_player][n_pocket]
    pocket[n_player][n_pocket] = 0
    pos_player = n_player
    pos_pocket = n_pocket
    for c in range(cnt_stone):
        pos_pocket += 1
        if pos_pocket == CNT_POCKET:
            goal[pos_player] +=1
            if c == cnt_stone - 1:
                # ゴールでちょうど終わる時
                return False
            else:
                pos_pocket = -1 # ポジションが最初に戻る。
                pos_player = next_player(pos_player)
        else:          
            pocket[pos_player][pos_pocket] += 1
    return True

def next_player(now_n_player):
    next_n_player = now_n_player + 1
    if next_n_player == CNT_PLAYER:
        next_n_player = 0
    return next_n_player

def is_selectable_pocket(n_player, n_pocket):
    if not n_pocket in SELECTABLE_N_POCKETS:
        return False
    if pocket[n_player][n_pocket] == 0:
        return False
    return True

def get_winner():
    """
    Returns: None: 未確定
             数値: 勝者のプレイヤー番号
    """
    for n_player, pocket_player in enumerate(pocket):
        if all([c == 0 for c in pocket_player]):
            return n_player
    return None

def play_mancala_stdio():
    print("========================================")
    print("Mancala Start !!")
    print("  (Game Stop " + str([GAME_STOPPED_CODE]) + ")")
    print("========================================")
    while True:
        try:
            turn_n_player = int(input("Select Start Player " + str(SELECTABLE_N_PLAYERS) + ": "))
            if turn_n_player == GAME_STOPPED_CODE:
                return
            if not turn_n_player in SELECTABLE_N_PLAYERS:
                raise Exception("Out of Selectable Players")
            break
        except:
            pass

    while True:
        print("========================================")
        print("Pocket: " + str(pocket))
        print("Goal: " + str(goal))
        print("Turn: " + str(turn_n_player))
        print("========================================")

        while True:
            try:
                select_n_pocket = int(input("Select Pocket " + str(SELECTABLE_N_POCKETS) + ": "))
                if select_n_pocket == GAME_STOPPED_CODE:
                    return
                if not is_selectable_pocket(turn_n_player, select_n_pocket):
                    raise Exception("Out of Selectable Pockets")
                break
            except:
                pass

        is_next_player = take_stone(turn_n_player, select_n_pocket)
        winner = get_winner()
        if winner is not None:
            print("")
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print("Game Over!!!")
            print("Winner Player: " + str(turn_n_player))
            break
        else:
            if is_next_player:
                turn_n_player = next_player(turn_n_player)

if __name__ == "__main__":
    play_mancala_stdio()




