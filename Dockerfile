FROM python:3.11-slim

ARG VERSION

LABEL maintainer="suzhetao@gmail.com"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get install -y python3-pip sshpass vim git openssh-client libhdf5-dev libssl-dev libffi-dev && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean

RUN rm -rf /usr/lib/python3.11/EXTERNALLY-MANAGED && \
  pip3 install --break-system-packages --upgrade pip && \
  pip3 install --break-system-packages simplejson cryptography paramiko pyopenssl six pyyaml requests passlib jmespath pywinrm cffi pyVim pyVmomi jmespath botocore boto3 lxml vmware-vapi-common-client==2.52.0 vmware-vapi-runtime==2.52.0 vmware-vcenter==8.0.3.0 && \
  pip3 install --break-system-packages --upgrade git+http://github.com/vmware/vsphere-automation-sdk-python.git && \
  pip3 install --break-system-packages ansible-core==${VERSION} ansible && \
  rm -rf /root/.cache/pip && \ 
  apt-get remove --auto-remove -y python3-pip

RUN mkdir /ansible && \
  mkdir -p /etc/ansible && \
  echo 'localhost' > /etc/ansible/hosts

WORKDIR /ansible

RUN pip3 list

CMD [ "ansible-playbook", "--version" ]