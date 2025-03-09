from mancala_rule import MancalaRule

# MAX_CNT_PLAY = 5000

CNT_PLAYER = 2 # プレイヤー数
CNT_POCKET = 4 # ポケット数 (プレイヤー1人当たり)
CNT_START_STONE = 1 # 初期の石数

DUMP_FILE_PATH = f'dump_{CNT_PLAYER}_{CNT_POCKET}_{CNT_START_STONE}.txt' # ダンプファイルパス

B_STATUS_DISALBE = b'\x00' # 無効状態のコード (石0個のポケットは選択不可のため。)

# マンカラのログ
# 状態バイナリ : [ポケット(0)選択後状態バイナリ, ポケット(1)選択後状態バイナリ, ,,, ]
#     ポケット選択後状態バイナリ → 選択可能だが、未設定の場合: None
#                            → 選択不可能の場合: B_STATUS_DISALBE
d_mancala_log = {}

def pack_status(turn_n_player, pocket):
    byte_ary = []
    byte_ary.append(turn_n_player)
    for pocket_player in pocket:
        byte_ary += pocket_player
    return bytes(byte_ary)

def unpack_status(b):
    offset = 0
    byte_ary = list(b)
    turn_n_player = byte_ary[offset]
    offset += 1
    pocket = []
    for c in range(CNT_PLAYER):
        pocket.append(byte_ary[offset: offset+ CNT_POCKET])
        offset += CNT_POCKET
    return (turn_n_player, pocket)

def next_play():
    for b_status_key, b_statuses in d_mancala_log.items():
        for n_pocket, b_status in enumerate(b_statuses):
            if b_status is None:
                return (b_status_key, n_pocket)
    return (None, None)

def add_status(b_status):
    if b_status not in d_mancala_log:
        (turn_n_player, pocket) = unpack_status(b_status)
        d_mancala_log[b_status] = []
        for c in range(CNT_POCKET):
            if pocket[turn_n_player][c] == 0:
                d_mancala_log[b_status].append(B_STATUS_DISALBE)
            else:
                d_mancala_log[b_status].append(None)
    return

# def is_complete_collect_by_status(b_status_key):
#     if all([ b_status is not None for b_status in d_mancala_log[b_status_key]]):
#         return True
#     return False

def dump_status():
    with open(DUMP_FILE_PATH, mode='w') as f:
        f.write(str(d_mancala_log).replace("[","[\n").replace("],","\n],\n"))

def collect_mancala_log():
    mancala_rule = MancalaRule(
        CNT_PLAYER, CNT_POCKET, CNT_START_STONE
    )
    for n_player in range(CNT_PLAYER):
        add_status(pack_status(n_player, mancala_rule.pocket))
    b_status = B_STATUS_DISALBE
    n_pocket = None
    cnt_play = 0
    while True:
        # if cnt_play > MAX_CNT_PLAY:
        #     break
        # else:
        #     cnt_play += 1
        b_status, n_pocket = next_play()
        if b_status is None:
            break
        (turn_n_player, pocket) = unpack_status(b_status)
        mancala_rule.turn_n_player = turn_n_player
        mancala_rule.pocket = pocket
        mancala_rule.goal = [0] * CNT_PLAYER # 未使用だが数が大きくなり過ぎるのでリセットする。
        mancala_rule.take_stone(n_pocket)
        if mancala_rule.turn_n_player is None:
            d_mancala_log[b_status][n_pocket]  = pack_status(turn_n_player, mancala_rule.pocket)
        else:
            b_status_next = pack_status(mancala_rule.turn_n_player, mancala_rule.pocket)
            d_mancala_log[b_status][n_pocket] = b_status_next
            add_status(b_status_next)


if __name__ == "__main__":
    collect_mancala_log()
    dump_status()
    print(len(d_mancala_log))