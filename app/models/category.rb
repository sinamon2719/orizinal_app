class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '教育' },
    { id: 3, name: '家電' },
    { id: 4, name: 'ファッション' },
    { id: 5, name: 'コスメ' },
    { id: 6, name: 'グルメ' },
    { id: 7, name: 'ホビー' },
  ]
end