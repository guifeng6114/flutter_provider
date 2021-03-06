import { listenAndServe, ServerRequest } from 'https://deno.land/std/http/mod.ts';

const body = "Hello World\n";
const options = { hostname: '10.237.188.40', port: 3400 };
listenAndServe(options, (req: ServerRequest) => {
  routes(req);
});
console.log(`Server running at ${ options.hostname }:${ options.port }`);

function routes(req: ServerRequest) {
  const { url } = req;
  console.log(url);
  const urlObject = new URL(url, `http://${ options.hostname }:${ options.port }`);
  switch(urlObject.pathname) {
    case '/login':
      const user = urlObject.searchParams.get('user');
      if (user) {
        req.respond({
          body: JSON.stringify({
            status: 'SUCCESS'
          })
        });
        console.log(`login: ${ user }`);
      } else {
        req.respond({
          body: JSON.stringify({
            status: 'ERROR'
          })
        });
      }
      break;
    case '/articles':
      const articles = [
        {
          articleName: '小石潭记',
          author: '柳宗元',
          id: 1,
          isSelected: true
        },
        {
          articleName: '岳阳楼记',
          author: '范仲淹',
          id: 2,
          isSelected: false
        },
        {
          articleName: '醉翁亭记',
          author: '欧阳修',
          id: 3,
          isSelected: false
        }
      ];
      req.respond({
        body: JSON.stringify({
          status: 'SUCCESS',
          articles
        })
      });
      console.log(`articles:`, articles);
  }
}