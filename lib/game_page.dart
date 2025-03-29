import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tic_tac_toe_game/board_model.dart';
import 'package:tic_tac_toe_game/constant.dart';
import 'package:tic_tac_toe_game/gen/assets.gen.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  /*
    0 | 1 | 2
    3 | 4 | 5
    6 | 7 | 8
*/

  var turn = 0;
  var winnerMessage = '';
  int winner = 2;
  bool status = false;
  var board = List.filled(9, BoardModel(isEmpty: true), growable: false);

  void changeTurn() {
    if (turn == 0) {
      turn = 1;
    } else {
      turn = 0;
    }
  }

  void checkWinner() {
    if (board[0].owner == board[1].owner &&
        board[0].owner == board[2].owner &&
        !board[0].isEmpty!) {
      setState(() {
        winnerMessage = 'Winner : Player ${board[0].owner! + 1}';
        winner = board[0].owner!;
      });
      status = true;
    } else if (board[3].owner == board[4].owner &&
        board[4].owner == board[5].owner &&
        !board[3].isEmpty!) {
      setState(() {
        winnerMessage = 'Winner : Player ${board[3].owner! + 1}';
        winner = board[3].owner!;
      });
      status = true;
    } else if (board[6].owner == board[7].owner &&
        board[7].owner == board[8].owner &&
        !board[6].isEmpty!) {
      setState(() {
        winnerMessage = 'Winner : Player ${board[6].owner! + 1}';
        winner = board[0].owner!;
      });
      status = true;
    } else if (board[0].owner == board[4].owner &&
        board[4].owner == board[8].owner &&
        !board[0].isEmpty!) {
      setState(() {
        winnerMessage = 'Winner : Player ${board[0].owner! + 1}';
        winner = board[0].owner!;
      });
      status = true;
    } else if (board[2].owner == board[4].owner &&
        board[4].owner == board[6].owner &&
        !board[2].isEmpty!) {
      setState(() {
        winnerMessage = 'Winner : Player ${board[2].owner! + 1}';
        winner = board[0].owner!;
      });
      status = true;
    } else if (board[0].owner == board[3].owner &&
        board[3].owner == board[6].owner &&
        !board[0].isEmpty!) {
      setState(() {
        winnerMessage = 'Winner : Player ${board[0].owner! + 1}';
        winner = board[0].owner!;
      });
      status = true;
    } else if (board[1].owner == board[4].owner &&
        board[4].owner == board[7].owner &&
        !board[1].isEmpty!) {
      setState(() {
        winnerMessage = 'Winner : Player ${board[1].owner! + 1}';
        winner = board[0].owner!;
      });
      status = true;
    } else if (board[2].owner == board[5].owner &&
        board[5].owner == board[8].owner &&
        !board[2].isEmpty!) {
      setState(() {
        winner = board[0].owner!;
        winnerMessage = 'Winner : Player ${board[2].owner! + 1}';
      });
      status = true;
    }
  }

  Widget iconXO(var player) {
    if (player == 1) {
      return SvgPicture.asset(
        Assets.images.ellipse1,
        height: 50,
      ).animate().fadeIn(duration: const Duration(milliseconds: 200));
    } else if (player == 0) {
      return SvgPicture.asset(
        Assets.images.vector1,
        height: 50,
      ).animate().fadeIn(duration: const Duration(milliseconds: 200));
    } else {
      return const SizedBox();
    }
  }

  Widget boardWidget(int index) {
    return GestureDetector(
      onTap: () {
        if (!status) {
          if (board[index].isEmpty!) {
            var br = BoardModel(owner: turn, isEmpty: false);
            board[index] = br;
            changeTurn();
            setState(() {});
            checkWinner();
          }
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(
              board[index].isEmpty!
                  ? 0xFF212835
                  : board[index].owner == 1
                  ? 0xFF87E43A
                  : 0xFFF54D62,
            ),
          ),
          color: Color(
            board[index].isEmpty!
                ? 0xFF212835
                : board[index].owner == 1
                ? 0xFF87E43A
                : 0xFFF54D62,
          ).withAlpha(40),
        ),

        alignment: Alignment.center,
        child: iconXO(board[index].owner),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            status
                ? Text(
                  '$winnerMessage Won!',
                  style: TextStyle(
                    color:
                        winner == 2
                            ? Colors.white
                            : winner == 1
                            ? green
                            : red,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ).animate().move(
                  begin: const Offset(0, -50),
                  duration: const Duration(milliseconds: 500),
                )
                : Text(
                  'Player ${turn + 1} Turn',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ).animate().fadeIn(duration: const Duration(milliseconds: 350)),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 450,
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 3 / 3,
                  maxCrossAxisExtent: 150,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 9,
                itemBuilder: (context, index) => boardWidget(index),
              ),
            ),

            Visibility(
              visible: status,
              child: Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: ElevatedButton.icon(
                  onPressed: () {
                    for (int i = 0; i < board.length; i++) {
                      board[i] = BoardModel(owner: null, isEmpty: true);
                    }
                    setState(() {
                      winnerMessage = '';
                      status = false;
                      turn = 0;
                    });
                  },
                  label: Text(
                    'Reset',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                  ),
                  icon: Icon(Icons.refresh, color: Colors.blueAccent, size: 24),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
              
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
