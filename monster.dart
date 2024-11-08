//시나리오 : 아래의 기능을 활용한 전투 RPG 게임 프로그램 만들기
//1. 랜덤으로 값을 뽑아내는 기능
//2. 파일 입출력을 처리하는 기능
//3. 객체 지향을 활용한 전체 구조 생각하기
//
//필수 정의
import 'dart:math';

import 'character.dart';

class Monster {
  //2.몬스터를 정의하기 위한 Monster 클래스
  String name;
  int health;
  int maxAttack;
  int defense = 0;

  Monster(this.name, this.health, this.maxAttack);

  void attackCharacter(Character character) {
    // 공격메서드
    Random rand = Random();
    int random = rand.nextInt(maxAttack);
    int damage = max(0, random - character.defense);

    character.health -= damage;
    print('$name이(가) ${character.name}에게 $damage의 데미지를 입혔습니다.');
    print('                                                            ');
  }

  void showStatus() {
    // 상태를 출력하는 메서드
    print('$name의 체력: $health, 공격력: $maxAttack');
  }
}
