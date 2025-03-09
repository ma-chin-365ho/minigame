from mancala_rule import MancalaRule

CNT_PLAYER = 2
CNT_POCKET = 3
CNT_START_STONE = 2
GAME_STOPPED_CODE = -1

def play_mancala_stdio():
    mancala_rule = MancalaRule(
        CNT_PLAYER, CNT_POCKET, CNT_START_STONE
    )

    print("========================================")
    print("Mancala Start !!")
    print("  (Game Stop " + str([GAME_STOPPED_CODE]) + ")")
    print("========================================")
    while True:
        try:
            turn_n_player = int(input("Select Start Player " + str(mancala_rule.selectable_n_players) + ": "))
            if turn_n_player == GAME_STOPPED_CODE:
                return
            if not turn_n_player in mancala_rule.selectable_n_players:
                raise Exception("Out of Selectable Players")
            break
        except:
            pass
    
    mancala_rule.turn_n_player = turn_n_player

    while True:
        print("========================================")
        print("Pocket: " + str(mancala_rule.pocket))
        print("Goal: " + str(mancala_rule.goal))
        print("Turn: " + str(mancala_rule.turn_n_player))
        print("========================================")

        while True:
            try:
                select_n_pocket = int(input("Select Pocket " + str(mancala_rule.selectable_n_pockets) + ": "))
                if select_n_pocket == GAME_STOPPED_CODE:
                    return
                if not mancala_rule.is_selectable_pocket(mancala_rule.turn_n_player, select_n_pocket):
                    raise Exception("Out of Selectable Pockets")
                break
            except:
                pass

        mancala_rule.take_stone(select_n_pocket)
        if mancala_rule.turn_n_player is None:
            print("")
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print("Game Over!!!")
            print("Winner Player: " + str(mancala_rule.winner))
            break

if __name__ == "__main__":
    play_mancala_stdio()




