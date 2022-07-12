return {
   p1 = {
      {
         {
            x = board.x - (board.w/2) + board.cw * 2,
            y = board.y
         },
         {
            x = board.x - (board.w/4),
            y = board.y - (board.h/4)
         },
         {
            x = board.x - (board.w/4),
            y = board.y + (board.h/4)
         },
         {
            x = board.x - board.cw,
            y = board.y - board.cw
         },
         {
            x = board.x - board.cw,
            y = board.y + board.cw
         }
      }
   },
   p2 = {
      {
         {
            x = board.x + (board.w/2) - board.cw * 2,
            y = board.y
         },
         {
            x = board.x + (board.w/4),
            y = board.y - (board.h/4)
         },
         {
            x = board.x + (board.w/4),
            y = board.y + (board.h/4)
         },
         {
            x = board.x + board.cw,
            y = board.y - board.cw
         },
         {
            x = board.x + board.cw,
            y = board.y + board.cw
         }
      }
   }
}