//시나리오 : 아래의 기능을 활용한 전투 RPG 게임 프로그램 만들기
//1. 랜덤으로 값을 뽑아내는 기능
//2. 파일 입출력을 처리하는 기능
//3. 객체 지향을 활용한 전체 구조 생각하기
//
//필수 정의
import 'dart:math';

import 'monster.dart';

class Character {
  //1.케릭터를 정의하기 위한 Character 클래스

  String name;
  int health;
  int attack;
  int defense;

  Character(this.name, this.health, this.attack, this.defense);

  void attackMonster(Monster monster) {
    // 공격메서드
    int damage = max(0, attack - monster.defense);
    monster.health -= damage;
    print('$name이(가) ${monster.name}에게 $damage의 데미지를 입혔습니다.');
    print('                                              ');
  }

  void defend() {
    // 방어메서드
    health += 10;
    print('$name이(가) 방어 태세를 취하여 10만큼의 체력을 얻었습니다.');
  }

  void showStatus() {
    // 상태를 출력하는 메서드
    print('$name의 체력: $health, 공격력: $attack, 방어력: $defense');
  }
}
