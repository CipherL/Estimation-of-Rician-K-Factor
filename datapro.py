
# import libraries
import os
import numpy as np
import scipy.io as sio
from sklearn import preprocessing
import pandas as pd
from PIL import Image

import torch
from torch.utils.data import Dataset

class LinkDataset(Dataset):
    def __init__(self, root_dir, txt_file, train=True):
        self.root_dir = root_dir
        self.train = train
        self.link_data = pd.read_csv(txt_file, ' ')

    def __len__(self):
        return len(self.link_data)

    def __getitem__(self, idx):
        mat_name = os.path.join(self.root_dir, self.link_data.iloc[idx, 0])
        # print('idx, mat_name', idx, mat_name)

        mat_data = sio.loadmat(mat_name)
        data = np.asarray(mat_data['data'])
        data = np.transpose(data, (2,0,1))
        data = data.astype(np.float32)
        label = self.link_data.iloc[idx, 1]
        metas = self.link_data.iloc[idx, 2:].as_matrix()
        metas = metas.astype('float')

        return torch.from_numpy(data), label

class LinkImageDataset(Dataset):
    def __init__(self, root_dir, txt_file, train=True):
        self.root_dir = root_dir
        self.train = train
        self.link_data = pd.read_csv(txt_file, ' ')

    def __len__(self):
        return len(self.link_data)

    def __getitem__(self, idx):
        img_name = os.path.join(self.root_dir, self.link_data.iloc[idx, 0])
        # print('idx, mat_name', idx, mat_name)

        input_img = np.asarray(Image.open(img_name).convert('RGB'))
        input_img = input_img.astype(np.float32)
        input_img = input_img.transpose((2, 0, 1))

        label = self.link_data.iloc[idx, 1]
        metas = self.link_data.iloc[idx, 2:].as_matrix()
        metas = metas.astype('float32')

        return torch.from_numpy(input_img), label
