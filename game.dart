//시나리오 : 아래의 기능을 활용한 전투 RPG 게임 프로그램 만들기
//1. 랜덤으로 값을 뽑아내는 기능
//2. 파일 입출력을 처리하는 기능
//3. 객체 지향을 활용한 전체 구조 생각하기
//
//필수 정의

import 'character.dart';
import 'dart:io';
import 'monster.dart';

class Game {
  //3.게임을 정의하기 위한 Game 클래스
  late Character character;
  late List<Monster> monsters;
  int defeatedMonsters = 0; //처리한 몬스터

  Game(this.character, this.monsters);

  Monster getRandomMonster() {
    //랜덤으로 몬스터를 불러오는 메서드
    List<Monster> randomMonsters = List.from(monsters);
    randomMonsters.shuffle();
    return randomMonsters.first;
  }

  void startGame() {
    //게임을 시작하는 메서드

    for (int i = 0; i < monsters.length && character.health > 0; i++) {
      Monster nowMonster = getRandomMonster();
      print('새로운 몬스터가 등장했습니다: ${nowMonster.name}');
      print('                                              ');

      while (nowMonster.health > 0 && character.health > 0) {
        battle(nowMonster);

        if (nowMonster.health <= 0) {
          defeatedMonsters++;
          print('몬스터를 물리쳤습니다! 물리친 몬스터 수 : $defeatedMonsters');
          print('                                                        ');

          if (defeatedMonsters >= monsters.length) {
            print('게임 승리!');
            return;
          }

          print('다음 몬스터와 대결하시겠습니까? (y/n)');
          String? responeMonster = stdin.readLineSync();

          if (responeMonster != 'y' && responeMonster != 'n') {
            print('잘못된 입력입니다.');
            print('               ');
          } else {
            if (responeMonster == 'n') {
              print('게임 종료!');
              return;
            } else if (responeMonster == 'y') {
              print('다음 몬스터가 나옵니다.');
            }
          }
        }
      }
      if (character.health < 0) {
        print('게임 종료! 패배하였습니다.');
      }
    }
  }

  void battle(Monster monster) {
    // 전투를 진행하는 메서드
    while (monster.health > 0 && character.health > 0) {
      print('${character.name}의 턴');
      print('공격하기(1) 방어하기(2)');
      String? action = stdin.readLineSync();
      if (action == '1') {
        character.attackMonster(monster);
      } else if (action == '2') {
        character.defend();
      } else {
        print('잘못된 입력입니다.');
        continue;
      }

      if (monster.health > 0) {
        print('${monster.name}의 턴');
        monster.attackCharacter(character);
      }
    }

    if (monster.health <= 0) {
      print('${monster.name}를 처치했습니다!');
    } else if (character.health <= 0) {
      print('${character.name}이(가) 사망했습니다. 게임 종료!');
    }
  }
}
