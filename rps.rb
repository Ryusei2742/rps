def janken
  # ジャンケンの手とあっち向いてホイの方向を配列に
  hands = ["グー", "チョキ", "パー"]
  directions = ["上", "下", "左", "右"]

  # 勝敗がつくまでループ
  loop do
    puts "\nじゃんけんをしましょう。以下の数字を入力してください。"
    puts "0: グー, 1: チョキ, 2: パー"
    # getsでプレイヤーの入力を受け取る。chompで改行を取り除く
    player_hand = gets.chomp

    # valid_input?:入力が0~2の範囲内かどうか確認する関数
    # 範囲外ならエラーメッセージ表示
    if !valid_input?(player_hand, 0..2)
      puts "不正な値です。0~2の数字を入力してください。"
      # nextでループの先頭に戻る
      next
    end

    # プレイヤーの入力を整数に変換
    player_hand = player_hand.to_i
    # rand(3)CPUの手を0~2の範囲内でランダムに決定
    cpu_hand = rand(3)
    # それぞれの手を表示
    puts "あなた: #{hands[player_hand]}, 相手: #{hands[cpu_hand]}"

    if player_hand == cpu_hand
      puts "あいこで..."
      # ループの先頭に戻り再度ジャンケン
      next
    end

    # determine_winner:勝者を判定するメソッド
    winner, loser = determine_winner(player_hand, cpu_hand)

    # winnerが:playerなら"あなた",そうでないなら"相手"と表示
    # 三項演算子: 条件式 ? 真の場合の値 : 義の場合の値
    # winnerに:playerが代入されていた場合は真、そうでなければ偽
    puts "じゃんけんの勝者は#{winner == :player ? 'あなた' : '相手'}です！"
    puts "次はあっち向いてホイです。"

    loop do
      puts "指を差す方向を選んでください。以下の数字を入力してください。"
      puts "0: 上, 1: 下, 2: 左, 3: 右"
      player_direction = gets.chomp

      if !valid_input?(player_direction, 0..3)
        puts "不正な値です。0~3の数字を入力してください。"
        next
      end

      player_direction = player_direction.to_i
      cpu_direction = rand(4)
      # 配列directions["上""下""左""右"]からplayer_direction(整数)番目の値(方向)を取り出す
      puts "あなた: #{directions[player_direction]}, 相手: #{directions[cpu_direction]}"

      # ジャンケンの勝者がプレイヤーで、あっち向いてホイの手が同じならプレイヤーの勝ち
      if winner == :player && player_direction == cpu_direction
        puts "あなたの勝ちです！\nゲーム終了。"
        return
      elsif winner == :cpu && player_direction == cpu_direction
        puts "相手の勝ちです！\nゲーム終了。"
        return
      else
        puts "勝負がつきませんでした。じゃんけんに戻ります。"
        # 一致しなければ再びジャンケンに戻る
        break
      end
    end
  end
end

  # 入力が数字のみか確認
def valid_input?(input, range)
  # range.include?(input.to_i) 入力された番号を整数型にして数字が指定された範囲内に含まれるか確認
  # ^:行の先頭を表す。\d:数字(0~9)にマッチする。\はエスケープ文字で、dを特殊な文字として解釈させる
  # +:直前のパターン(今回は\d)が1回以上連続して現れることを意味する。例:"123"ok ""(空文字)ng など
  # $:行の末尾を意味する。このパターンが文字列の末尾まで一致することを指定
  # /^\d+$/:行の先頭から末尾までが1つ以上の数字だけで構成されている文字列にマッチする (文字や小数点、空文字は弾く)
  # match?:Rubyのメソッド。引数に渡された正規表現が文字列にマッチするかを審議値で返す
  input.match?(/^\d+$/) && range.include?(input.to_i)
end

# 勝者を判定する
# グー(0) > チョキ(1), チョキ(1) > パー(2), パー(2) > グー(0)
def determine_winner(player_hand, cpu_hand)
  if (player_hand - cpu_hand) % 3 == 1
    # プレイヤーが勝者、CPUが敗者
    [:player, :cpu]
  else
    [:cpu, :player]
  end
end

def determine_winner(player_hand, cpu_hand)
  if player_hand == 0 && cpu_hand == 1 || # グー > チョキ
     player_hand == 1 && cpu_hand == 2 || # チョキ > パー
     player_hand == 2 && cpu_hand == 0    # パー > グー
    [:player, :cpu] # プレイヤー勝利
  elsif cpu_hand == 0 && player_hand == 1 || # グー > チョキ
        cpu_hand == 1 && player_hand == 2 || # チョキ > パー
        cpu_hand == 2 && player_hand == 0    # パー > グー
    [:cpu, :player] # CPU勝利
  else
    [:draw, :draw] # 引き分け
  end
end

# ゲームの開始
janken
