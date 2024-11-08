//시나리오 : 아래의 기능을 활용한 전투 RPG 게임 프로그램 만들기
//1. 랜덤으로 값을 뽑아내는 기능
//2. 파일 입출력을 처리하는 기능
//3. 객체 지향을 활용한 전체 구조 생각하기
//
//필수 정의
import 'dart:io';
import 'dart:math';

import 'character.dart';
import 'monster.dart';

import 'game.dart';

//
//필수 기능 가이드
//1.파일로부터 데이터 읽어오기 기능
Character loadCharacterStats(String fileName) {
  //캐릭터 정보를 불러오기
  try {
    final file = File('characters.txt');
    final contents = file.readAsStringSync();
    final stats = contents.split(',');

    if (stats.length != 3) throw FormatException('유효하지 않은 캐릭터 데이터입니다.');

    int health = int.parse(stats[0]);
    int attack = int.parse(stats[1]);
    int defense = int.parse(stats[2]);
    String name = getCharacterName();

    var character = Character(name, health, attack, defense);
    print('캐릭터가 생성되었습니다');
    print('                     ');
    character.showStatus();
    return character;
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

List<Monster> loadMonsterStats(String fileName) {
  //몬스터 정보를 불러오기
  try {
    final file = File('monsters.txt');
    final contents = file.readAsLinesSync();
    List<Monster> monsters = [];

    for (var line in contents) {
      final stats = line.split(',');
      if (stats.length != 3) throw FormatException('유효하지 않은 몬스터 데이터입니다.');

      String name = stats[0];
      int health = int.parse(stats[1]);
      int maxAttack = Random().nextInt(int.parse(stats[2])) + 1; //랜덤 공격력

      monsters.add(Monster(name, health, maxAttack));
    }
    return monsters;
  } catch (e) {
    print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

String getCharacterName() {
  RegExp validName = RegExp(r'^[a-zA-Z]+$');
  String? name;

  while (true) {
    print('캐릭터의 이름을 입력하세요 (영문만 허용):');
    name = stdin.readLineSync();

    if (name != null && validName.hasMatch(name)) {
      print("유효한 이름입니다.");
      print("                  ");
      return name;
    } else {
      print('유효하지 않은 이름입니다. 다시 입력해주세요.');
      print("                                           ");
    }
  }
}

//
void saveResult(Character character) {
  // 게임 종료 후 결과를 파일에 저장하는 기능
  while (true) {
    print('결과를 저장하시겠습니까? (y/n)');
    String? answer = stdin.readLineSync();

    if (answer == 'y') {
      final file = File('result.txt');
      file.writeAsStringSync(
          '이름: ${character.name}, 체력: ${character.health}, 결과: ${character.health > 0 ? "승리" : "패배"}');
      print('결과가 저장되었습니다.');
      print('게임을 종료합니다.');
      break;
    } else if (answer == 'n') {
      print('결과를 저장하지 않습니다.');
      print('게임을 종료합니다.');
      break;
    } else {
      print('잘못된 입력입니다.');
    }
  }
}

void main() {
  Character character = loadCharacterStats('characters.txt');
  List<Monster> monsters = loadMonsterStats('monsters.txt');

  Game game = Game(character, monsters);
  game.startGame();

  saveResult(character);
}
//
//주의 사항
//1.예외 처리를 통해 파일이 없거나 잘못된 형식의 데이터를 읽었을 때 프로그램이 종료되지 않도록 합니다.
//2.사용자 입력에 대한 검증을 철저히 하여 예상치 못한 입력으로 인한 오류를 방지합니다.
//3.코드의 재사용성과 가독성을 높이기 위해 함수와 클래스를 적절히 활용합니다.

