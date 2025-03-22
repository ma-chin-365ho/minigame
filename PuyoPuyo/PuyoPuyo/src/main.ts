import Phaser from 'phaser';
import MyScene from './scenes/MyFirstScene';

const config: Phaser.Types.Core.GameConfig = {
  type: Phaser.AUTO,
  width: 800,
  height: 600,
  physics: {
    default: 'arcade',
    arcade: {
      gravity: { x: 0, y: 200 },
      debug: false,
    },
  },
  scene: MyScene,
};
new Phaser.Game(config);
